set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=80

filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

map tN :call MoveToNextTab()<CR>
map tP :call MoveToPrevTab()<CR>
"map zz :ConqueTermVSplit bash<CR>
map zs :setlocal spell spelllang=
map zh :!cat ~/.vimrc \| grep map<CR>

set backspace=indent,eol,start

au! BufNewFile,BufRead *.rs
au BufNewFile,BufRead *.rs set filetype=marcdown

set t_Co=16

function IndentHiToggle()
    :IndentGuidesToggle
    hi IndentGuidesEven ctermbg=gray
    hi IndentGuidesOdd ctermbg=darkgray
endfunc

map zgi :call IndentHiToggle()<CR>
