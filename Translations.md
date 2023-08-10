> ⚠️ **Warning**
>
> This wiki has been replaced by the wiki on [our website](https://luals.github.io/wiki/translations). This wiki will be removed in the future.

# Translations
Translations can be found in the [`locale/`](https://github.com/LuaLS/lua-language-server/tree/master/locale) directory within a directory of their own. These directories should be named using the [BCP 47 Code](https://docs.microsoft.com/en-us/openspecs/office_standards/ms-oe376/6c085406-a698-4e12-9d4d-c3b0ee3dbc4a) for that language.

> ℹ Note: All translations are provided and collaborated on by the community. If you find an inappropriate or harmful translation, [please report it immediately](https://github.com/LuaLS/lua-language-server/issues).

## Current Translations
So far, the below languages are available:

|                                   BCP 47 Code                                    |       Language Name (English)        |
| :------------------------------------------------------------------------------: | :----------------------------------: |
| [en-us](https://github.com/LuaLS/lua-language-server/tree/master/locale/en-us) |       English - United States        |
| [pt-br](https://github.com/LuaLS/lua-language-server/tree/master/locale/pt-br) |         Portuguese - Brazil          |
| [zh-cn](https://github.com/LuaLS/lua-language-server/tree/master/locale/zh-cn) | Chinese - People's Republic of China |
| [zh-tw](https://github.com/LuaLS/lua-language-server/tree/master/locale/zh-tw) |           Chinese - Taiwan           |

These languages can be selected manually by using the [`--locale`](https://github.com/LuaLS/lua-language-server/wiki/Getting-Started#locale) flag. It can be entered on the [command line](https://github.com/LuaLS/lua-language-server/wiki/Getting-Started#command-line) or entered into [`misc.parameters`](https://github.com/LuaLS/lua-language-server/wiki/Settings#miscparameters) if using Visual Studio Code.


## Contributing
All contributions are welcome, whether it be grammar corrections, spelling fixes, or support for a whole new language. However, we do ask that translations are done by those with a considerable amount of fluency in the target language and is not done primarily using a machine translator. While translators are improving rapidly, they still make plenty of mistakes that will be harder to find and fix if the translation appears "complete". We want the translations to be clear and make sense for native users, unfortunately, translators are still not able to achieve this all the time.

To contribute, you will want to fork the repository, make your changes to the translations found in [`locale/`](https://github.com/LuaLS/lua-language-server/tree/master/locale), and then open a [pull request](https://github.com/LuaLS/lua-language-server/pulls) to merge your changes in. The `zh-cn` and `en-us` languages are kept the most up to date and should be used as a reference when translating to another language.

Thank you for your interest and thank you to [all contributors of translations](https://github.com/LuaLS/lua-language-server/commits/master/locale)!
