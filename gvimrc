" Make default directory windows user home folder
cd $USERPROFILE

" Turn off the toolbar by default
set go-=m go-=T

" Set window size larger
set lines=45 columns=105

" Better default font
if has("gui_win32")
    set guifont=DejaVu_Sans_Mono:h10
endif
