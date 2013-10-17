# Vim Awesome Configuration

## Requirements
* Vim (of course)
* Python support

## Installation
It's as simple as that:

```bash
git clone https://github.com/ivyl/vim-config.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodule init
git submodule update
```

##Plugins
* [commentary](https://github.com/tpope/vim-commentary)
* [ctrlp](https://github.com/kien/ctrlp.vim)
* [fugitive](https://github.com/tpope/vim-fugitive)
* [gundo](https://github.com/sjl/gundo.vim)
* [markdown](https://github.com/tpope/vim-markdown)
* [markmultiple](https://github.com/adinapoli/vim-markmultiple)
* [matchit](http://www.vim.org/scripts/script.php?script_id=39)
* [pathogen](https://github.com/tpope/vim-pathogen)
* [repeat](https://github.com/tpope/vim-repeat)
* [scala](https://github.com/derekwyatt/vim-scala)
* [surround](https://github.com/tpope/vim-surround)
* [tabular](https://github.com/godlygeek/tabular)
* [unimpaired](https://github.com/tpope/vim-unimpaired)
* [textobj-indent](https://github.com/kana/vim-textobj-indent)
* [ruby](https://github.com/vim-ruby/vim-ruby)
* [coffee](https://github.com/kchmck/vim-coffee-script)
* [bundler](https://github.com/tpope/vim-bundler)
* [vroom](https://github.com/skalnik/vim-vroom)
* [crosshairs](https://github.com/chreekat/vim-paren-crosshairs)
* [indentLine](https://github.com/Yggdroot/indentLine)
* [bling](https://github.com/ivyl/vim-bling)


##Theme
* Transxoria - modified, transparent [xoria256](http://www.vim.org/scripts/script.php?script_id=2140)

## Bindings
* enter - hides higlighting and behaves well in command edit mode
* \l - toggle show invisibles
* \h - toggle highligh search matches
* \g - gundo toggle
* \cc - togle color column at textwidth+1
* \cd - :lcd %:h
* \s - togle spell checking
* \v - edit your vimrc in new tab, config is reloaded on save
* \n - toggle between normal/relative line numbering
* &lt;C-n&gt; - start mark multiple (marks occurences which you can then edit at
  one)
* &lt;C-m&gt; - from visual, clean after mark multiple
* &lt;C-k&gt; - move your code one line up
* &lt;C-j&gt; - move your code one line down
* &lt;C-p&gt; - file search/open (ctrlp plugin)
* gb - open ctrl-p buffer browsing
* \r - run current/last test file
* \R - run nearest/last neaerest test
* &lt;nr&gt;zy - save view number <nr>, think of this as fold yank
* &lt;nr&gt;zp - load view number <nr>, think of this as fold paste
* :Sw - does sudo write of edited file (:w !sudo tee % > /dev/null)
* :&& - && expands to current file's path in ex mode
* - - switch between common "things"

## Motions
* ai, ii - indented block

## Features
* [pathogen](https://github.com/tpope/vim-pathogen) enabled
* lot of useful options enabled (wildmenu, encoding, nocompatible, tabs, wraps, etc.)
* editing gziped files
* minimalized GUI
* nice invisibles

## Thanks
Drew for his [Vimcasts](http://vimcasts.org/) and Practical Vim book
Derek Wyatt for his [posts on Vim](http://www.derekwyatt.org/vim/)
