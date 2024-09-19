local gojsonschema = require("gojsonschema")


local schema = [[
{
    "type": "object",
    "properties": {
        "name": {
            "type": "string"
        },
        "age": {
            "type": "integer"
        }
    },
    "required": ["name", "age"]
}
]]

local right_doc = [[
{
    "name": "John",
    "age": 20
}
]]

local wrong_doc = [[
{
    "name": "John",
    "age": "aaaa"
}
]]

describe("validate", function()
  it("should validate false", function()
        local valid, reason = gojsonschema.validate(schema, wrong_doc)
        assert.is_false(valid)
        assert.equal("The document invalid. See errors:  age: Invalid type. Expected: integer, given: string", reason)
        assert.is_string(reason)
  end)
  it("should validate true", function()
        local valid, reason = gojsonschema.validate(schema, right_doc)
        assert.is_true(valid)
        assert.is_nil(reason)
  end)
end)