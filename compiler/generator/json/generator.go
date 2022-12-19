/*
 * Copyright 2020 Workiva
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package json

import (
	"encoding/json"
	"os"

	"github.com/Workiva/frugal/compiler/generator"
	"github.com/Workiva/frugal/compiler/parser"
)

const (
	defaultOutputDir = "gen-json"
)

// Generator generates JSON descriptor files.
type Generator struct {
	options map[string]string
	// generated is true if Generate has been called. Generate is called once
	// per included file, but the output contains all transitive dependencies,
	// so there is nothing to do except for the second and subsequent calls.
	generated bool
}

var _ generator.ProgramGenerator = (*Generator)(nil)

// NewGenerator returns a generator for JSON descriptor files.
func NewGenerator(options map[string]string) generator.ProgramGenerator {
	return &Generator{
		options: options,
	}
}

// GetOutputDir returns the dir unchanged.
func (*Generator) GetOutputDir(dir string, frugal *parser.Frugal) string {
	return dir
}

// DefaultOutputDir returns "gen-json".
func (*Generator) DefaultOutputDir() string {
	return defaultOutputDir
}

// UseVendor returns false.
func (*Generator) UseVendor() bool {
	return false
}

// Generate writes a type library to the output directory.
func (g *Generator) Generate(pf *parser.Frugal, outputDir string) error {
	if g.generated {
		return nil
	}
	g.generated = true

	f, err := os.OpenFile(outputDir+"/frugal.json", os.O_CREATE|os.O_WRONLY|os.O_TRUNC, 0644)
	if err != nil {
		return err
	}
	defer f.Close()

	frugals := collectFrugals(pf, []*parser.Frugal{}, map[string]struct{}{})
	ff := toFiles(frugals)

	enc := json.NewEncoder(f)
	if _, ok := g.options["indent"]; ok {
		enc.SetIndent("", "  ")
	}

	return enc.Encode(ff)
}

// collectFrugals returns all recursively referenced parser.Frugal.
func collectFrugals(pf *parser.Frugal, frugals []*parser.Frugal, used map[string]struct{}) []*parser.Frugal {
	if _, ok := used[pf.Name]; ok {
		return frugals
	}
	used[pf.Name] = struct{}{}
	frugals = append(frugals, pf)

	for _, include := range pf.OrderedIncludes() {
		inclFrugal := pf.ParsedIncludes[include.Name]
		frugals = collectFrugals(inclFrugal, frugals, used)
	}

	return frugals
}

type frugalFile struct {
	Services map[string]*service    `json:"s,omitempty"`
	Scopes   map[string]*scope      `json:"c,omitempty"`
	Types    map[string]*frugalType `json:"t,omitempty"`
}

type frugalType struct {
	Annotations  map[string]string `json:"a,omitempty"`
	Base         string            `json:"b,omitempty"`
	Key          *frugalType       `json:"k,omitempty"`
	Value        *frugalType       `json:"v,omitempty"`
	Name         string            `json:"n,omitempty"`
	EnumValues   map[int][]string  `json:"e,omitempty"`
	StructFields map[int]*field    `json:"s,omitempty"`
	UnionFields  map[int]*field    `json:"u,omitempty"`
}

type service struct {
	Methods map[string]*method `json:"m"`
}

type scope struct {
	Prefix     string                 `json:"p"`
	Operations map[string]*frugalType `json:"o,omitempty"`
}

type method struct {
	Params  map[int]*field `json:"p,omitempty"`
	Results map[int]*field `json:"r,omitempty"`
}

type field struct {
	Name string      `json:"n,omitempty"`
	Type interface{} `json:"t"`
}

func toFiles(frugals []*parser.Frugal) map[string]*frugalFile {
	files := map[string]*frugalFile{}
	for _, pf := range frugals {
		files[pf.Name] = toFile(pf)
	}
	return files
}

func toFile(pf *parser.Frugal) *frugalFile {
	f := &frugalFile{
		Types:    map[string]*frugalType{},
		Services: map[string]*service{},
		Scopes:   map[string]*scope{},
	}

	for _, ps := range pf.Services {
		f.Services[ps.Name] = toService(ps)
	}
	for _, ps := range pf.Scopes {
		f.Scopes[ps.Name] = toScope(ps)
	}

	for _, pt := range pf.Typedefs {
		f.Types[pt.Name] = toType(pt.Type)
	}

	for _, pe := range pf.Enums {
		f.Types[pe.Name] = toEnum(pe)
	}

	for _, ps := range pf.Structs {
		f.Types[ps.Name] = toStructType(ps)
	}
	for _, pu := range pf.Unions {
		f.Types[pu.Name] = toUnionType(pu)
	}
	for _, pe := range pf.Exceptions {
		f.Types[pe.Name] = toStructType(pe)
	}

	return f
}

func toService(ps *parser.Service) *service {
	s := &service{
		Methods: map[string]*method{},
	}

	for _, pm := range ps.Methods {
		s.Methods[pm.Name] = toMethod(pm)
	}

	return s
}

func toMethod(pm *parser.Method) *method {
	m := &method{
		Params:  map[int]*field{},
		Results: map[int]*field{},
	}

	for _, pf := range pm.Arguments {
		m.Params[pf.ID] = toField(pf)
	}

	if pm.ReturnType != nil {
		m.Results[0] = &field{Type: toType(pm.ReturnType)}
	}
	for _, pf := range pm.Exceptions {
		m.Results[pf.ID] = toField(pf)
	}

	return m
}

func toField(pf *parser.Field) *field {
	return &field{
		Name: pf.Name,
		Type: toType(pf.Type),
	}
}

func toScope(ps *parser.Scope) *scope {
	s := &scope{
		Prefix:     ps.Prefix.String,
		Operations: map[string]*frugalType{},
	}

	for _, po := range ps.Operations {
		s.Operations[po.Name] = toType(po.Type)
	}

	return s
}

var baseTypes = map[string]struct{}{
	"bool":   struct{}{},
	"byte":   struct{}{},
	"i8":     struct{}{},
	"i16":    struct{}{},
	"i32":    struct{}{},
	"i64":    struct{}{},
	"double": struct{}{},
	"string": struct{}{},
	"binary": struct{}{},
}

func toType(pt *parser.Type) *frugalType {
	t := toRawType(pt)
	if len(pt.Annotations) != 0 {
		t.Annotations = map[string]string{}
		for _, pa := range pt.Annotations {
			t.Annotations[pa.Name] = pa.Value
		}
	}
	return t
}

func toRawType(pt *parser.Type) *frugalType {
	if pt.IsContainer() {
		switch {
		case pt.Name == "list":
			return &frugalType{Value: toType(pt.ValueType)}
		case pt.Name == "set":
			return &frugalType{Key: toType(pt.ValueType)}
		case pt.Name == "map":
			return &frugalType{
				Key:   toType(pt.KeyType),
				Value: toType(pt.ValueType),
			}
		}
		panic("unknown container type " + pt.Name)
	}

	if _, ok := baseTypes[pt.Name]; ok {
		return &frugalType{Base: pt.Name}
	}
	return &frugalType{Name: pt.Name}
}

func toStructFields(ps *parser.Struct) map[int]*field {
	fields := map[int]*field{}
	for _, pf := range ps.Fields {
		fields[pf.ID] = &field{
			Name: pf.Name,
			Type: toType(pf.Type),
		}
	}
	return fields
}

func toStructType(ps *parser.Struct) *frugalType {
	return &frugalType{StructFields: toStructFields(ps)}
}

func toUnionType(ps *parser.Struct) *frugalType {
	return &frugalType{UnionFields: toStructFields(ps)}
}

func toEnum(pe *parser.Enum) *frugalType {
	values := map[int][]string{}
	for _, pev := range pe.Values {
		values[pev.Value] = append(values[pev.Value], pev.Name)
	}
	return &frugalType{EnumValues: values}
}
