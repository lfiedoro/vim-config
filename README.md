# Vim Awesome Configuration

## Requirements
* Vim (of course)

## Installation
It's as simple as that:

```bash
git clone https://github.com/ivyl/vim-config.git ~/.vim
cd ~/.vim
git submodule init
git submodule update
vim +PluginInstall +qall
```

Newer Vim is fine with $HOME/.vim/vimrc. If you use older one that doens't
support that feature (check :help vimrc) you need to:

```bash
ln -s ~/.vim/vimrc ~/.vimrc
```

##Plugins
see `plugins.vim` for list


##Theme
* Transxoria - modified, transparent [xoria256](http://www.vim.org/scripts/script.php?script_id=2140)

## Bindings
* space - easymotion prefix
* enter - hides higlighting and behaves well in command edit mode
* \l - toggle show invisibles
* \h - toggle highligh search matches
* \g - gundo toggle
* \cc - toggle smart color column at textwidth+1
* \CC - toggle regular color column at textwidth+1
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
* gy - open ctrl-p tag browsing
* \r - run current/last test file
* \R - run nearest/last neaerest test
* &lt;nr&gt;zy - save view number <nr>, think of this as fold yank
* &lt;nr&gt;zp - load view number <nr>, think of this as fold paste
* :Sw - does sudo write of edited file (:w !sudo tee % > /dev/null)
* :&& - && expands to current file's path in ex mode
* \f - reformat current buffer using clang-format
* \h - switch between .h and .cpp files
* \H - open complementary .h / .cpp in vertcial split
* \b - opens tagbar that autocolse
* \= - increase gui font size
* \\- - decrease gui font size

## Commands
* :Sw - sudo write
* :Swq - sudo write and quit
* :Sprunge - paste to sprunge
* :TPane - execute command in tmux pane

See `mappings.vim` for more details.

## Motions
* ai, ii - indented block
* ae, ie - entire file
* a\_, i\_ - underscore

## Features
* [vundle](https://github.com/gmarik/Vundle.vim) enabled
* lot of useful options enabled (wildmenu, encoding, nocompatible, tabs, wraps, etc.)
* editing gziped files
* minimalized GUI
* nice invisibles
* highlighting of characters over 80th column
* highlighting of tailing white spaces

## neovim
Whole configuration and most plugins works with [neovim](http://neovim.org/).
Just clone repo into `$HOME/.nvim` or link it there.

## Thanks
Drew for his [Vimcasts](http://vimcasts.org/) and Practical Vim book
Derek Wyatt for his [posts on Vim](http://www.derekwyatt.org/vim/)
