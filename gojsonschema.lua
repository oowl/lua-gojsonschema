local ffi  = require "ffi"
local C  = ffi.C
local gojsonschema = ffi.load("./gojsonschema.so")

ffi.cdef([[
    typedef struct { const char *p; ptrdiff_t n; } GoString;
    typedef unsigned char GoUint8;
    extern GoUint8 validate(GoString schema, GoString doc, GoString* reason);
]])

local function validate(schema, doc)
    local reason = ffi.new("GoString")
    local valid = gojsonschema.validate({schema, #schema}, {doc, #doc}, reason)
    if valid == 1 then
        return true
    else
        return false, ffi.string(reason.p, reason.n)
    end
end

return {
    validate = validate
}