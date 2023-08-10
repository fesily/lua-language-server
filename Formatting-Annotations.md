> ⚠️ **Warning**
>
> This wiki has been replaced by the wiki on [our website](https://luals.github.io/wiki/annotations/#annotation-formatting). This wiki will be removed in the future.

# Formatting Annotations
This page explains how you can format your annotations to have special appearances.

## Markdown Support
Annotations support most of the [markdown syntax](https://www.markdownguide.org/cheat-sheet/).

### Headings
You can define headings in your annotation using `#`, with one appearing for each level of heading. So `#` is an `<h1>` and `###` is an `<h3>`. The limit is `######` (6).

<details>
<summary>Example</summary>

`# Heading`
`## Heading 2`

</details>

### Bold Text
Text surrounded in `**` will be bolded.

<details>
<summary>Example</summary>

`**Bold text!**`

</details>

### Italic Text
Text surrounded in `*` will be italicized.

<details>
<summary>Example</summary>

`*italicized text*`

</details>

### Struckthrough Text
Text surrounded in `~~` will be struck through.

<details>
<summary>Example</summary>

`Three strikes and you're ~~in~~ out`

</details>

### Ordered List
To create an ordered list, just start counting with each item on a new line. Each item should start with a number followed by a period and then a space.

<details>
<summary>Example</summary>

```
1. Item 1
2. Item 2
```

</details>

### Unordered List
To create an unordered list, place a `*` or `-` before each list element, with each list element appearing on a new line.

<details>
<summary>Example</summary>

```
- Item 1
- Item 2
```

</details>

### Blockquote
Text beginning with a `>` will be turned into a blockquote. This will result in it being indented.

<details>
<summary>Example</summary>

`> My quoted text`

</details>

### Code
To make a small piece of code stand out, place it in backticks `` ` ``.

<details>
<summary>Example</summary>

`` `myVariable` ``

</details>

### Code Block
To insert a larger snippet of Lua code, you can start and end a code block with 3 backticks ` ``` `.

<details>
<summary>Example</summary>

````
```
function()
    print("Hello!")
end
```
````

</details>

### Horizontal Rule
To add a horizontal divide/rule, use `***` or `---` on its own line.

<details>
<summary>Example</summary>

```
Something
---
divided
```

</details>

### Link
To add a link, place the alt text in square brackets with the url immediately following in parentheses.

<details>
<summary>Example</summary>

`[GitHub Repository](https://github.com/LuaLS/lua-language-server)`

</details>

### Image
To add an image, place a `!`, followed by the alt text in square brackets, with the url immediately following in parentheses.

<details>
<summary>Example</summary>

`![Huskies in the snow](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Huskiesatrest.jpg/2880px-Huskiesatrest.jpg)`

</details>

## New line
There are many ways to add newlines to your annotations.

The most bulletproof way is to simply add an extra line of just `---`, although this functions like a paragraph break, not a newline.

The below methods can be added to the end of a line:

- HTML `<br>` tag (recommended)
- Two trailing spaces
- `\n` new line escape character
- Markdown backslash `\` ([Not recommended](https://www.markdownguide.org/basic-syntax#line-break-best-practices))
