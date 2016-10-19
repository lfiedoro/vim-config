# (N)Vim Awesome Configuration

## Requirements
* (*N)Vim (of course)

## Installation
It's as simple as that:

```bash
git clone https://github.com/ivyl/vim-config.git ~/.config/nvim
cd ~/.config/nvim
git submodule init
git submodule update
nvim +PlugInstall +qall
```

Then, from time to time, run:

```
nvim +PlugUpgrade +PlugUpdate +qall
```

I also recommend setting VISUAL and EDITOR enviromental variables to nvim.

## Plugins
See `plugins.vim` for list.


## Theme
* [gruvbox256](https://github.com/morhetz/gruvbox)

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
* \h - switch between .h and .c files
* \H - open complementary .h / .c in vertcial split
* \j - switch between .h and .cpp files
* \J - open complementary .h / .cpp in vertcial split
* \b - opens tagbar that autocolse
* \= - increase gui font size
* \\- - decrease gui font size

## Commands
* :Sw - sudo write
* :Swq - sudo write and quit
* :Sprunge - paste to sprunge
* :TPane - execute command in tmux pane

See `mappings.vim` for more details.

## Additional Motions
* ai, ii - indented block
* ae, ie - entire file
* a\_, i\_ - underscore

## Features
* [vim-plug](https://github.com/junegunn/vim-plug) enabled
* lot of useful options enabled (wildmenu, encoding, nocompatible, tabs, wraps, etc.)
* editing gziped files
* minimalized GUI
* nice invisibles
* highlighting of characters over 80th column
* highlighting of tailing white spaces

## "Legacy" Vim
From now on it's kinda not supported as paths for plugins are hardcoded to
follow new XDG notation. I may fix that in the future when I'll encounter a
machine where I can't install nvim.

## Thanks
Drew for his [Vimcasts](http://vimcasts.org/) and Practical Vim book.

Derek Wyatt for his [posts on Vim](http://www.derekwyatt.org/vim/)
