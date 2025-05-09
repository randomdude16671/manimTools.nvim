<h1 align="center"> manimTools.nvim </h1>


<h3 align="left">Installation</h3> 
<h5 align="left"><a href="github.com/folke/lazy.nvim">Lazy.nvim </a></h5>
```lua
{ 
    "randomdude16671/manimTools.nvim", 
    lazy = true, 
    ft = "python",
    opts = {} -- for defaults
} 
``` 

<h5 align="left"><a href="github.com/lewis6991/pckr.nvim">Pckr.nvim </a></h5> 

```lua
{
    "randomdude16671/manimTools.nvim", 
    ft = { "python" },
    config = function()
        require("manim").setup()
    end
}
```

<h3 align="left">Commands provided</h3> 
- `:ManimRender` render a given scene
- `:ManimOpenPreview` open preview (default previewer is vlc.) 
