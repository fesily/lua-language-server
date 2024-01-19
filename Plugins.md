> ⚠️ **Warning**
>
> This wiki has been replaced by the wiki on [our website](https://luals.github.io/wiki/plugins/). This wiki will be removed in the future.

# Plugins
Plugins can be used to modify how the language server works.

## Usage
This does not provide hinting or reporting of custom syntax errors, however, it will let you create a custom syntax that will then be output to a separate file.

![](https://github.com/LuaLS/vscode-lua/raw/master/images/plugin-diff.gif?raw=true)

## Setup
1. Add `--develop=true` to [`Lua.misc.parameters`](https://github.com/LuaLS/lua-language-server/wiki/Settings#miscparameters)
   - This allows the plugin to write to [`LOGPATH/diffed.lua`](https://github.com/LuaLS/lua-language-server/wiki/FAQ#where-can-i-find-the-log-file)
2. Create `.vscode/lua/plugin.lua` in your workspace (or some other absolute location)
3. Specify the path of the plugin via the [`Lua.runtime.plugin`](https://github.com/LuaLS/lua-language-server/wiki/Settings#plugin) setting

[Debug the plugin](https://github.com/LuaLS/lua-language-server/wiki/Developing#debugging)

## Functions


### `OnSetText(uri, text)`
This function provides the uri and text of the file that has been edited and expects a list of differences to be returned. The result will be written to `diffed.lua` in your [log location](https://github.com/LuaLS/lua-language-server/wiki/FAQ#where-can-i-find-the-log-file).

#### Definition
```lua
---@class diff
---@field start  integer # The number of bytes at the beginning of the replacement
---@field finish integer # The number of bytes at the end of the replacement
---@field text   string  # What to replace

---@param  uri  string # The uri of file
---@param  text string # The content of file
---@return nil|diff[]
function OnSetText(uri, text) end
```

### `OnTransformAst(uri, ast)`
This function provides the ability to modify `ast`. 

After the token is generated and before the comments are compiled, so it is possible to modify ast directly and ensure that changes to the comments take effect as well.

You can return new one `ast` or modify the origin `ast`.

### Definition
```lua
---@param  uri  string # The uri of file
---@param  ast  parser.object # The file ast
---@return parser.object? ast
function OnTransformAst(uri, ast) end
```

### `VM.OnCompileFunctionParam(next, func, param)`
This function modifies the behavior of a function when compiling (presumably) the type of its arguments.

`next` is the compiler's default behavior for functions. `func` is the function to be compiled, `param` is the parameter.
If all functions return `false`, the parameter is defined as `any`.

### Definition
```lua
---@param next  fun(func:parser.object, param:parser.object) # Default behavior
---@param func  parser.object                                # The function
---@param param parser.object                                # The param
---@return boolean? ready                                    # Already know the type.
function VM.OnCompileFunctionParam(next, func, param) end
```

## Example

### OnSetText

![](https://github.com/LuaLS/vscode-lua/raw/master/images/plugin-diff.gif?raw=true)

```lua
function OnSetText(uri, text)
    if text:sub(1, 4) ~= '--##' then
        return nil
    end
    local diffs = {}
    diffs[#diffs+1] = {
        start  = 1,
        finish = 4,
        text   = '',
    }

    for localPos, colonPos, typeName, finish in text:gmatch '()local%s+[%w_]+()%s*%:%s*([%w_]+)()' do
        diffs[#diffs+1] = {
            start  = localPos,
            finish = localPos - 1,
            text   = ('---@type %s\n'):format(typeName),
        }
        diffs[#diffs+1] = {
            start  = colonPos,
            finish = finish - 1,
            text   = '',
        }
    end

    return diffs
end
```

### VM.OnCompileFunctionParam

```lua

local nodeHelper = reuqire 'nodeHelper'
-- Create pattern that already matches code in the form of `*.components.`
local pattern = nodeHelper.createFieldPattern("*.components")

function VM.OnCompileFunctionParam (next, func, param)
    -- Call the default 
    if next(func, param) then
        return true -- If ready known the type, return true. Also you can continue
    end
    -- Try match pattern
    if nodeHelper.matchPattern(source, pattern) then
        -- Add a TestClass type to the parameters that match the pattern
        local type = vm.declareGlobal('type', 'TestClass', TESTURI)
        vm.setNode(source, vm.createNode(type, source))
        return true
    end
end

```
## Template
[https://github.com/LuaLS/sample-plugin](https://github.com/LuaLS/sample-plugin)
