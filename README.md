<div align="center">

# SharedUtil

<img src="https://img.shields.io/badge/SharedUtil-v1.0.0-7aa2f7?style=for-the-badge&logoColor=white" alt="version" />
<img src="https://img.shields.io/badge/Luau-Roblox-00A2FF?style=for-the-badge&logoColor=white" alt="luau" />
<a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-9ece6a?style=for-the-badge" alt="license" /></a>
<a href="https://github.com/Vikmanou/SharedUtil/actions/workflows/test.yml"><img src="https://img.shields.io/badge/Tests-passing-1abc9c?style=for-the-badge" alt="tests" /></a>


<p>Utility modules for Roblox game development.</p>

<a href="https://vikmanou.github.io/SharedUtil/">View docs →</a>

</div>

<div>&nbsp;</div>

<!--moonwave-hide-before-this-line-->

## Packages

| Package | Description | docs | source |
| ------- | ------------ | ---- | ------ |
| [Math](https://vikmanou.github.io/SharedUtil/api/Math) | Mathematical utility function. | [docs](https://vikmanou.github.io/SharedUtil/api/Math) | [source](modules/math) |
| [String](https://vikmanou.github.io/SharedUtil/api/String) | String utility functions. | [docs](https://vikmanou.github.io/SharedUtil/api/String) | [source](modules/string) |

## Installation

Each module is a standalone `init.luau` under [`modules/`](modules). Copy the file you need into your project and require it.

## Testing

Tests run with [Lute](https://github.com/luau-lang/lute), a plain-Luau runtime.

```sh
lute test
```