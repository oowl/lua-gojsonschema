package main

import "C"
import "github.com/xeipuuv/gojsonschema"

//export validate
func validate(schema string, doc string, reason *string) bool {
	schemaLoader := gojsonschema.NewStringLoader(schema)
	documentLoader := gojsonschema.NewStringLoader(doc)
	result, err := gojsonschema.Validate(schemaLoader, documentLoader)
	if err != nil {
		*reason = err.Error()
		return false
	}

	if result.Valid() {
		return true
	}

	ireason := "The document invalid. See errors: "
	for _, desc := range result.Errors() {
		ireason += " " + desc.String()
	}
	*reason = ireason
	return false
}

func main() {
}
