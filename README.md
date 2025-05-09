<h1 align="center">manimTools.nvim</h1>

<h3 align="left">Installation</h3>

<h4>Using <a href="https://github.com/folke/lazy.nvim">Lazy.nvim</a></h4>

```lua
{
    "randomdude16671/manimTools.nvim",
    lazy = true,
    ft = "python",
    opts = {} -- use this to override defaults
}
```

<h4>Using <a href="https://github.com/lewis6991/pckr.nvim">Pckr.nvim</a></h4>

```lua
{
    "randomdude16671/manimTools.nvim",
    ft = { "python" },
    config = function()
        require("manim").setup()
    end
}
```

<h3 align="left">Commands Provided</h3>

- `:ManimRender` – Render a given scene  
- `:ManimOpenPreview` – Open preview (default previewer is VLC)
```
