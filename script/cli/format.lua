local lang = require 'language'


local path  = FORMAT
if type(path) ~= 'string' then
    print(lang.script('CLI_CHECK_ERROR_TYPE', type(DOC)))
    return
end

local uri = files.getRealUri(params.textDocument.uri)

local state = files.getState(uri)
if not state then
    return nil
end

if not config.get(uri, 'Lua.format.enable') then
    return nil
end

local pformatting = require 'provider.formatting'
pformatting.updateConfig(uri)

local core = require 'core.formatting'
local edits = core(uri, params.options)
if not edits or #edits == 0 then
    return nil
end

local results = {}
for i, edit in ipairs(edits) do
    results[i] = {
        range   = converter.packRange(state, edit.start, edit.finish),
        newText = edit.text,
    }
end

return results
