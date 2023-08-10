> ⚠️ **Warning**
>
> This wiki has been replaced by the wiki on [our website](https://luals.github.io/wiki/definition-files). This wiki will be removed in the future.

# Libraries
Libraries can be used to provide definitions that allow you to very closely emulate your target environment without actually `require`-ing them.

They can be extremely powerful, but they can also come with [some performance issues](https://github.com/LuaLS/lua-language-server/wiki/FAQ#how-can-i-improve-startup-speeds) when they are very large or there are many being included.

<br>

## Custom
You can create your own libraries through various methods.

The definition files can be created using the same [annotations](https://github.com/LuaLS/lua-language-server/wiki/Annotations) you use in your Lua scripts. Make sure to include a [`@meta`](https://github.com/LuaLS/lua-language-server/wiki/Annotations#meta) tag in your definition files.

<br>

### Placing in Your Workspace
**Difficulty:** Easy

**Use Case:** Not Recommended

This is the easiest method, as you only need to drop your library definitions and/or source code into your workspace directory (under a `definitions/` or `types/` directory is recommended).

This may be usable for a very small project, however, for larger ones, especially those with source control, **it is not recommended.** This is because you now have your development definitions in with your source code making them hard to re-use and they will need to be git ignored anyways.

<br>

### Link to Workspace
**Difficulty:** Easy

**Use Case:** Any Workspace

This method uses the [`workspace.library`](https://github.com/LuaLS/lua-language-server/wiki/Settings#workspacelibrary) setting to link the requested library to your workspace scope. This is great for allowing you to store your libraries elsewhere and then include them when needed through your [configuration file](https://github.com/LuaLS/lua-language-server/wiki/Configuration-File).

Unless you **always** use a certain library, it is strongly recommended you only define `workspace.library` in each project/workspace using `.vscode/settings.json` or `.luarc.json` in order to prevent slowdowns from loading unnecessary libraries.

<br>

### Addon
**Difficulty:** Medium

**Use Case:** Proper Emulation of Target Environment

This method is the most in-depth and allows you to very closely emulate your target environment for many projects with easy repeatability. If your target environment is a game engine where you may not have access to all of Lua, this is a great option.

Check out the [Addons](https://github.com/LuaLS/lua-language-server/wiki/Addons) page to learn more!

Have an environment emulation to share? Add it to [LLS-Addons](https://github.com/LuaLS/LLS-Addons)!

## Built-in Libraries

<blockquote>
	<br>
	<div align="center">
		🚮 <b>DEPRECATED</b> 🚮
	</div>
	<br>
	<div align="center">
		<a href="https://github.com/LuaLS/lua-language-server/discussions/1950">Built-in libraries are going to be removed in a future version</a> in favour of using the addon manager and to cut down on bloat. You can of course still also manually download any of the addons from <a href="https://github.com/LuaLS/LLS-Addons">LLS-Addons</a> (or elsewhere) and add them to <a href="https://github.com/LuaLS/lua-language-server/wiki/Settings#workspaceuserthirdparty"><code>workspace.userThirdParty</code></a> or <a href="https://github.com/LuaLS/lua-language-server/wiki/Settings#workspacelibrary"><code>workspace.library</code></a>.
	</div>
	<br>
</blockquote>

There are a number of built-in third party libraries that can be found in [`meta/3rd/`](https://github.com/LuaLS/lua-language-server/tree/master/meta/3rd). These are all implemented as [addons](#addon). These include:

- `Cocos 4.0`
- `Jass`
- `OpenResty`
- `lfs`
- `love2d`
- `lovr`
- `skynet`
- `luassert`
- `busted`
- `luaecs`
- `Defold`

<br>

### Automatically Applying
When opening a workspace, you may be prompted to apply a library should your workspace contain certain keywords. You will be given three options:

1. Apply and modify settings
   - Apply the library so that you get completions, saving the activated library to your [configuration file](https://github.com/LuaLS/lua-language-server/wiki/Configuration-File). Next time you load the workspace up, the library will again be loaded.
2. Apply but do not modify settings
    - **Temporarily** apply the library so that you get completions. When the server is restarted, the library will no longer be loaded and you will once again receive this popup.
3. Don't show again
   - Stop suggesting to apply libraries. This sets [`workspace.checkThirdParty`](https://github.com/LuaLS/lua-language-server/wiki/Settings#workspacecheckthirdparty) to `false` in your [configuration file](https://github.com/LuaLS/lua-language-server/wiki/Configuration-File).

<br>

### Manually Applying
In case the popup doesn't appear or you have purposefully set [`workspace.checkThirdParty`](https://github.com/LuaLS/lua-language-server/wiki/Settings#workspacecheckthirdparty) to `false`, you can still manually apply a library using [`workspace.library`](https://github.com/LuaLS/lua-language-server/wiki/Settings#workspacelibrary). The path can use `${3rd}` to refer to the built-in libraries folder location. The path for `love2d` looks like `${3rd}/love2d/library`.

Here is an example of how you can apply the `OpenResty` library:

<details>
<summary>VS Code Settings</summary>

```json
{
    "Lua.runtime.version": "LuaJIT",
    "Lua.diagnostics.globals": [
        "ngx"
    ],
    "Lua.workspace.library": [
        "${3rd}/OpenResty/library"
    ]
}
```

</details>

<details>
<summary><a href="https://github.com/LuaLS/lua-language-server/wiki/Configuration-File#luarcjson"><code>.luarc.json</code></a></summary>

```json
{
    "runtime.version": "LuaJIT",
    "diagnostics.globals": [
        "ngx"
    ],
    "workspace.library": [
        "${3rd}/OpenResty/library"
    ]
}
```

</details>


The [`workspace.library`](https://github.com/LuaLS/lua-language-server/wiki/Settings#workspacelibrary) setting always follows the pattern of `${3rd}/LIBRARY_NAME/library`, but the other settings seen in the examples above are unique to the library being applied. To see the settings that the server would have [applied automatically](#automatically-applying), navigate to the library's [`config.lua`](#configuration-file) in the [`meta/3rd/`](https://github.com/LuaLS/lua-language-server/tree/master/meta/3rd) folder.

## Bundling in a plugin extension
* _Disclaimer: This article was written by a [user](https://github.com/LuaLS/lua-language-server/issues/417)._

An [extension](https://code.visualstudio.com/api/get-started/your-first-extension) that ships its own EmmyLua folder(s) can choose to automatically add this path.

1. Add an extension [dependency](https://code.visualstudio.com/api/references/extension-manifest) to your `package.json`
```json
    "extensionDependencies": [
        "sumneko.lua"
    ],
```

2.  Add the path to your folder(s) in the configuration.
```ts
function setExternalLibrary(folder: string, enable: boolean) {
	const extensionId = "publisher.name" // this id is case sensitive
	const extensionPath = vscode.extensions.getExtension(extensionId)?.extensionPath
	const folderPath = extensionPath+"\\"+folder
	const config = vscode.workspace.getConfiguration("Lua")
	const library: string[] | undefined = config.get("workspace.library")
	if (library && extensionPath) {
		// remove any older versions of our path e.g. "publisher.name-0.0.1"
		for (let i = library.length-1; i >= 0; i--) {
			const el = library[i]
			const isSelfExtension = el.indexOf(extensionId) > -1
			const isCurrentVersion = el.indexOf(extensionPath) > -1
			if (isSelfExtension && !isCurrentVersion) {
				library.splice(i, 1)
			}
		}
		const index = library.indexOf(folderPath)
		if (enable) {
			if (index == -1) {
				library.push(folderPath)
			}
		}
		else {
			if (index > -1) {
				library.splice(index, 1)
			}
		}
		config.update("workspace.library", library, true)
	}
}

setExternalLibrary("EmmyLua", true)
```
```json
    "Lua.workspace.library": [
        "c:\\Users\\UserName\\.vscode\\extensions\\publisher.name-0.0.2\\EmmyLua"
    ],
```
Note that when your extension is uninstalled this path will still remain in the configuration.
1. After restarting VS Code, the extension files will be removed from disk. However the EmmyLua files would still be already preloaded.
2. ~~Only on the second restart will the EmmyLua files not be preloaded since the extension is now gone.~~ The extension files will still be on disk. [https://github.com/Ketho/vscode-wow-api/issues/20](https://github.com/Ketho/vscode-wow-api/issues/20)

There is a [deactivate()](https://code.visualstudio.com/api/references/activation-events) event and an [uninstall hook](https://code.visualstudio.com/api/references/extension-manifest#extension-uninstall-hook) but it appears they [cannot edit](https://github.com/microsoft/vscode/issues/45474) the configuration.
