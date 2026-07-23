<div align="center">

# SharedUtil

<a href="https://vikmanou.github.io/SharedUtil/">
  <img src="https://github.com/Vikmanou/SharedUtil/actions/workflows/docs.yml/badge.svg" alt="Documentation status" />
</a>
<a href="https://github.com/Vikmanou/SharedUtil/actions/workflows/test.yml">
  <img src="https://github.com/Vikmanou/SharedUtil/actions/workflows/test.yml/badge.svg" alt="Tests status" />
</a>
<a href="LICENSE">
  <img src="https://img.shields.io/badge/License-MIT-9ece6a?style=for-the-badge" alt="license" />
</a>

<p>Utility modules for Roblox game development.</p>

<a href="https://vikmanou.github.io/SharedUtil/">View docs →</a>

</div>

<div>&nbsp;</div>

<!--moonwave-hide-before-this-line-->

## Packages

| Package | Description | docs | source |
| ------- | ------------ | ---- | ------ |
| [Math](https://vikmanou.github.io/SharedUtil/api/Math) | Numeric, geometry, physics, GUI and number-theory helpers for Roblox. | [docs](https://vikmanou.github.io/SharedUtil/api/Math) | [source](modules/math) |
| [Table](https://vikmanou.github.io/SharedUtil/api/Table) | Table utility helpers. | [docs](https://vikmanou.github.io/SharedUtil/api/Table) | [source](modules/table) |

## Installation

Each module is a standalone `init.luau` under [`modules/`](modules). Copy the folder you need into your project and require it, or sync the whole repo in with [Rojo](https://rojo.space/).

## Testing

Tests run with [Lute](https://github.com/luau-lang/lute), a plain-Luau runtime.

```sh
lute test
```

### Roblox-only functions

Lute has no Roblox datatypes, so functions taking or returning `Vector3`, `CFrame`,
`Color3`, `Vector2`, `Instance` or `GuiObject` cannot be exercised under `lute test`.
