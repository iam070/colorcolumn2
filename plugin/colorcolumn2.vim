if exists('loaded_colorcolumn2_plugin')
    finish
endif
let loaded_colorcolumn2_plugin = 1

if !exists('g:colorcolumn2_enable_filetypes')
    let g:colorcolumn2_enable_filtypes = []
endif

if !exists('g:colorcolumn2_ignore_filetypes')
    let g:colorcolumn2_ignore_filetypes = []
endif

if !exists('g:colorcolumn2_column_list')
    let g:colorcolumn2_column_list  = ['80']
endif

if !exists('g:colorcolumn2_ctermbg')
    let g:colorcolumn2_ctermbg = 236
endif

if !exists('g:colorcolumn2_guibg')
    let g:colorcolumn2_guibg = '#232526'
endif

function! ShouldMatchColorColumn()
    for ft in g:colorcolumn2_ignore_filetypes
        if ft ==# &filetype | return 0 | endif
    endfor
    return 1
endfunction

function! ColorColumnBgSet()
    exec 'highlight ColorColumn ctermbg='.g:colorcolumn2_ctermbg
    exec 'highlight ColorColumn guibg='.g:colorcolumn2_guibg
endfunction

function! ColorColumn2Enable()
    for cc_pos in g:colorcolumn2_column_list
        exec "setlocal cc+=".cc_pos
    endfor
endfunction

function! ColorColumn2Disable()
    exec "setlocal cc="
endfunction

function! ColorColumn2Toggle()
    if &cc == ''
        call ColorColumn2Enable()
    else
        call ColorColumn2Disable()
    endif
endfunction

call ColorColumnBgSet()
autocmd BufRead,BufNewFile * if ShouldMatchColorColumn() |  call ColorColumn2Enable() | endif
command! ColorColumn2Enable call ColorColumn2Enable()
command! ColorColumn2Disable call ColorColumn2Disable()
command! ColorColumn2Toggle call ColorColumn2Toggle()
