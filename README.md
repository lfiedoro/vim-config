# Vim awesome configuration

## Requirements
* Vim (of course)
* Python support
* PyGtk

##Installation
It's as simple ass that:

```bash
git clone https://github.com/ivyl/vim-config.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodule init
git submodule update
```

##Plugins
* [fugitive](https://github.com/tpope/vim-fugitive)
* [xmledit](https://github.com/sukima/xmledit/)
* [colorpicker](https://github.com/vim-scripts/VIM-Color-Picker)
* [gundo](https://github.com/sjl/gundo.vim)
* [tabular](https://github.com/godlygeek/tabular)
* [unimpaired](https://github.com/tpope/vim-unimpaired)
* [hexhighlight](http://www.vim.org/scripts/script.php?script_id=2937)
* [supertab](http://www.vim.org/scripts/script.php?script_id=1643)
* [surround](https://github.com/tpope/vim-surround)
* [commentary](https://github.com/tpope/vim-commentary)
* [ctrlp](https://github.com/kien/ctrlp.vim)
* [pathogen](https://github.com/tpope/vim-pathogen)
* [repeat](https://github.com/tpope/vim-repeat)
* [markdown](https://github.com/tpope/vim-markdown)
* [scala](https://github.com/derekwyatt/vim-scala)

##Theme
[railscasts](http://railscasts.com/about) with transparent background
[aldmeris](http://www.vim.org/scripts/script.php?script_id=3673)

##Bindings
* \l - toggle show invisibles
* \h - toggle highligh search matches
* \g - gundo toggle
* \. \, \[ \] - resize splits
* \s - togle spell checking
* \v - edit your vimrc in new tab, config is reloaded on save
* :Sw - does sudo write of edited file (:w !sudo tee % > /dev/null)
* <C-k> - move your code one line up
* <C-j> - move your code one line down
* <C-p> - file search/open (ctrlp plugin)

##Features
* editing gziped files
* minimalized GUI
* nice invisibles


##Thanks
Drew for his [vimcasts](http://vimcasts.org/)
