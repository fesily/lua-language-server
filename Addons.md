> ⚠️ **Warning**
>
> This wiki has been replaced by the wiki on [our website](https://luals.github.io/wiki/addons). This wiki will be removed in the future.

An addon allows users to add content to the Lua Language Server. [LLS-Addons][LLS-Addons] is a repository where you can find community-created addons.

An addon can:

- Include definitions for a framework/library.
- Contain a [plugin](https://github.com/LuaLS/lua-language-server/wiki/Plugins)
- Modify a user's settings to better emulate the target environment.

# Installing Addons

> **Note**
> If you use VS Code, addons can easily be installed and enabled by the [addon manager](#vs-code-addon-manager).

Addons can be installed from the [LLS-Addons][LLS-Addons] repository. The intention with the repository is that each addon is its own sub-repository so they can be forked and downloaded easily. Take a look through the `addons/` directory and open up your desired addon. Clicking `module` will bring you to the repository where that addon lives.

![openresty directory in LLS-Addons/addons showing module and config.json file](https://user-images.githubusercontent.com/61925890/214354486-3804b2ca-b2e2-455e-8bfb-7ba13b0f43ef.png)

You can then download the zip for that addon and unzip it to some directory, any directory, on your computer (e.g. `C:\Users\me\Documents\LuaAddons`). You can place any future addons in this directory as well, just make sure they are contained within their own directory. Then add the path to this parent directory to [`workspace.userThirdParty`](https://github.com/LuaLS/lua-language-server/wiki/Settings#workspaceuserthirdparty).

```bash
📂 LuaAddons/
    ├── 📂 Addon1/
    │    ├── 📁 library/
    │    ├── 📜 config.json
    │    └── 📜 plugin.lua
    └── 📂 Addon2/
         ├── 📁 library/
         └── 📜 config.json
```
Here is an example of what your setting may look like in your [configuration file](https://github.com/LuaLS/lua-language-server/wiki/Configuration-File).
```json
{
    "Lua.workspace.userThirdParty": ["C:\Users\me\Documents\LuaAddons"]
}
```

# Enabling Addons
Addons define some configuration values in their [`config.json`](#configjson) file that are meant to be automatically applied, but can still be applied manually.

> **Note**
> If you use VS Code, addons can easily be installed and enabled by the [addon manager](#vs-code-addon-manager).

## Automatically Enabling
If the addon in question has been configured to allow automatic enabling, and you have set up [`workspace.userThirdParty`](https://github.com/LuaLS/lua-language-server/wiki/Settings#workspaceuserthirdparty), you will be prompted to enable the addon once certain critera is met. The critera is defined by the addon in its [`config.json`](#configjson) file - this may be using `require` to require the library or naming a file a certain way.


## Manually Enabling
If the addon contains a `library/` directory, you will want to paste the **full** path to that directory in your [`workspace.library` setting](https://github.com/LuaLS/lua-language-server/wiki/Settings#workspacelibrary).

If the [`config.json`](#configjson) contains settings, you will have to manually copy them to your [configuration file](https://github.com/LuaLS/lua-language-server/wiki/Configuration-File).

# VS Code Addon Manager
The addon manager in VS Code allows you to easily browse addons from [LLS-Addons][LLS-Addons]. It can be opened from the command palette (<kbd>Ctrl + P</kbd>) by running the "Open Addon Manager" command (`lua.addon_manager.open`).

![GIF showing usage of addon manager](https://user-images.githubusercontent.com/61925890/219545232-d7b45d56-6761-4589-a195-0a6d22989320.gif)

It will handle modifying your [configuration file](https://github.com/LuaLS/lua-language-server/wiki/Configuration-File) to apply any defintions and settings that the addon includes.

The addon manager opens in a [webview](https://code.visualstudio.com/api/extension-guides/webview) (basically an iframe) that contains a [Vue.js webapp](https://github.com/LuaLS/vscode-lua-webvue).

If you have feedback on the addon manager, please leave it in the [vscode-lua repository](https://github.com/LuaLS/vscode-lua) ❤️.

# Creating an Addon
To create an addon, you will want to first create a directory where all your files will live. If you intend to make your addon publicly available, you will also want a remote repository where people can access it. Both GitHub and GitLab have been confirmed to work, although any service that provides Git cloning over HTTP should work.

> **Note**
> For details on how to publish your addon to the VS Code addon manager, check out the [LLS-Addons repository](https://github.com/LuaLS/LLS-Addons#readme).

## Structure of an Addon
An addon that contains definitions should place them in a `library/` directory. You can use the [LuaLS/addon-template](https://github.com/LuaLS/addon-template) to get up and running a little bit quicker.

```bash
📂 myAddon/
    ├── 📁 library/
    │    ├── 📜 http.lua
    │    └── 📜 error.lua
    ├── 📜 plugin.lua
    └── 📜 config.json
```

## Definition Files
The definition files should live in the `library/` directory and should start with a [`@meta`](https://github.com/LuaLS/lua-language-server/wiki/Annotations#meta) annotation. They can use [LuaCATS annotations](https://github.com/LuaLS/lua-language-server/wiki/Annotations) just like any Lua code.

## Plugins
A plugin can be included simply by placing it in the addon folder and naming it `plugin.lua`.

## Addon Configuration
The `config.json` file is very important for addons and **must** be included. A schema for it can be found at [`LLS-Addons/schemas/addon.schema.json`](https://github.com/LuaLS/LLS-Addons/blob/main/schemas/addon_config.schema.json). You can also browse some of the addons in that repository to see how the `config.json` file can be used. The `settings` array can contain any VS Code settings, including [settings for the language server](https://github.com/LuaLS/lua-language-server/wiki/Settings).

### `config.json`
```json
{
    // Name of the addon
    "name": "My Awesome Addon",

    // Lua string patterns to look for in a workspace.
    // If detected, this addon will be recommended to enable
    "words": [ "require[%s%(\"']+MAA[%)\"']" ],

    // Lua string patterns to look for in filenames.
    // If detected, this addon will be recommended to enable
    "files": ["my-awesome-file.lua"],

    // List of settings to apply when this addon is enabled
    "settings": {
        "Lua.diagnostics.globals" : [
            "awesome"
        ]
    }
}
```

[LLS-Addons]: https://github.com/LuaLS/LLS-Addons
