{lib , pkgs , config  ,  ... } :
let
  cfg = config.zathura-custom ;
in  {
  options.zathura-custom  = {
    enable = lib.mkEnableOption "enbale zathura custom config" ;
  } ;

  config  = lib.mkIf cfg.enable { 
    programs.zathura = {
      enable = true;
      extraConfig = ''
# Being an Emacs user, it is natural for me to use emacs-like and info-like keybindings for zathura.
# 
# Zathura configuration documentation is available at
# https://git.pwmt.org/pwmt/zathura/-/blob/e5d2ca487147e79d0bb7acbf5174cd9dcc92a86c/doc/man/zathurarc.5.rst
# A full list of available functions and default keybindings is available at
# https://git.pwmt.org/pwmt/zathura/-/blob/e5d2ca487147e79d0bb7acbf5174cd9dcc92a86c/zathura/config.c#L301
# 
# If you want to integrate Zathura with Emacs AUCTeX mode, see
# [emacs wiki](https://www.emacswiki.org/emacs/AUCTeX).
# 
# Put the following inside `$XDG_CONFIG_HOME/zathura/zathurarc

## niceties
# when selecting text with mouse,
# copy to clipboard
set selection-clipboard clipboard

# keep several lines of text when
# scrolling a screenful
set scroll-full-overlap 0.2

# see documentation for details
set scroll-page-aware true
set window-title-basename true
set adjust-open width
set statusbar-home-tilde true
set vertical-center true
set synctex true
# large bold font easier on the eyes in index mode
# status bar can be disabled with A-s
set font "FreeSans bold 16"
set zoom-step 3

'' ;
      mappings = {      
        "[normal] <C-b>" =  " scroll left" ;
        "[normal] h" =  " scroll left" ;
        "[normal] <C-n>" = "scroll down";
        "[normal] j" = "scroll down";
        "[normal] <C-p>" =  "scroll up";
        "[normal] k" =  "scroll up";
        "[normal] <C-f>" =  "scroll right";
        "[normal] l" =  "scroll right";
        "[normal] <C-g>" =  "abort";
        "[insert] <C-g>" =  "abort";
        "[normal] <C-[>" =  "abort";
        "[normal] <A-\<>" =  "goto top";
        "[normal] <A-\>>" = "goto bottom";
        "[normal] a" =  "adjust_window best-fit";
        "[normal] s" =  "adjust_window width";
        "[normal] F" =  "display_link";
        "[normal] <C-c>" = "copy_link";
        "[normal] f" = "follow";
        "[normal] m" =  "mark_add";
        "[normal] \\' " = "mark_evaluate";
        "[normal] \\," =  "navigate next";
        "[normal] \\." =  "navigate previous";
        "[normal] <A-Right>" = "navigate next";
        "[normal] <A-Left>" = "navigate previous";
        "[normal] <PageDown>" = "scroll full-down";
        "[normal] <PageUp>" = "scroll full-up";
        "[normal] <C-P>" = "print";
        "[normal] c" = "recolor";
        "[normal] R" =  "reload";
        "[normal] v" =  "rotate rotate_cw";
        "[normal] V" =  " rotate rotate_caw";
        "[normal] <Left>" = "scroll left";
        "[normal] <Up>" = "scroll up";
        "[normal] <Down>" = "scroll down";
        "[normal] <Right>" = "scroll right";
        "[normal] <A-a>" = "scroll half-left";
        "[normal] <C-V>" = "scroll half-down";
        "[normal] <A-V>" = "scroll half-up";
        "[normal] <A-e>" = "scroll half-right";
        "[normal] <C-a>" = "scroll full-left";
        "[normal] <C-v>" = "scroll full-down";
        "[normal] <Return>" = "scroll full-down";
        "[normal] <A-v>" = "scroll full-up";
        "[normal] <C-e>" = "scroll full-right";
        "[normal] <Space>" = "scroll full-down";
        "[normal] <C-h>" = "scroll full-up";
        "[normal] <BackSpace>" = "scroll full-up";
        "[normal] <S-Space>" = "scroll full-up";
#        "[normal] l" = "jumplist backward";
        "[normal] r" =  "jumplist forward";
        "[normal] <A-r>" = "bisect forward";
        "[normal] <A-l>" = "bisect backward";
        "need to use '/'" =  " to trigger search";
        " [normal] <C-s>" = "search forward";
        "[normal] <C-r>" = "search backward";
        "[normal] p" = " snap_to_page";
        "[normal] <C-i>" = "toggle_index";
        "[normal] i" = "toggle_index";
        "[normal] <Tab>" = "toggle_index";
        "[normal] <A-s>" = "toggle_statusbar";
        "[normal] <A-i>" = "focus_inputbar";
        "[normal] d" = " toggle_page_mode";
        "[normal] q" = "quit" ;
        " [normal] + " = " zoom in";
        "[normal] - " = "zoom out";
        "[normal] = "  = "zoom in";
        " [normal] <A-P>" = "toggle_presentation";
        "[normal] <A-F>" = "toggle_fullscreen";
#         "[normal] j" = " toggle_fullscreen";
#        " [fullscreen] j" = " toggle_fullscreen";
        "[fullscreen] q" =  " toggle_fullscreen";
        "[fullscreen] <C-b>" = "scroll left";
        "[fullscreen] <C-n>" = "scroll down";
        "[fullscreen] <C-p>" = "scroll up";
        "[fullscreen] <C-f>" = "scroll right";
        "[fullscreen] h" = "scroll left";
        "[fullscreen] j" = "scroll down";
        "[fullscreen] k" = "scroll up";
        "[fullscreen] l" = "scroll right";
        "[fullscreen] <C-g>" = "abort";
        "[fullscreen] <C-[>" = "abort";
        "[fullscreen] <A-\<>" = "goto top";
        "[fullscreen] <A-\>>" = "goto bottom";
        "[fullscreen] a " =  "adjust_window best-fit";
        " [fullscreen] s" = " adjust_window width";
        "[fullscreen] F" = " display_link" ;
        " [fullscreen] <C-c>" = "copy_link";
        "[fullscreen] f" =  "follow";
        "[fullscreen] m" = "mark_add";

        " [fullscreen] \\'" = " mark_evaluate" ;
        " [fullscreen] \\,"=  "navigate next";
        " [fullscreen] \\. " = "navigate previous" ;
        " [fullscreen] <A-Right>" = "navigate next";
        "[fullscreen] <A-Left>" = "navigate previous";
        "[fullscreen] <PageDown>" = "scroll full-down";
        "[fullscreen] <PageUp>" = "scroll full-up";
        "[fullscreen] <C-P>" = "print";
        "[fullscreen] c" =  " recolor" ;
        "[fullscreen] R" = " reload" ;
        "[fullscreen] v" = " rotate rotate_cw";
        " [fullscreen] V" = " rotate rotate_ccw";
        " [fullscreen] <Left>" = "scroll left";
        "[fullscreen] <Up>" = "scroll up";
        "[fullscreen] <Down>" = "scroll down";
        "[fullscreen] <Right>" = "scroll right";
        "[fullscreen] <A-a>" = "scroll half-left";
        "[fullscreen] <C-V>" = "scroll half-down";
        "[fullscreen] <A-V>" = "scroll half-up";
        "[fullscreen] <A-e>" = "scroll half-right";
        "[fullscreen] <C-a>" = "scroll full-left";
        "[fullscreen] <C-v>" = "scroll full-down";
        "[fullscreen] <Return>" = "scroll full-down";
        "[fullscreen] <A-v>" = "scroll full-up";
        "[fullscreen] <C-e>" = "scroll full-right";
        "[fullscreen] <Space>" = "scroll full-down";
        "[fullscreen] <C-h>" = "scroll full-up";
        "[fullscreen] <BackSpace>" = "scroll full-up";
        "[fullscreen] <S-Space>" = "scroll full-up";
        "[fullscreen] l " = "jumplist backward" ;
        " [fullscreen] r" = " jumplist forward";
        "[fullscreen] <A-r>" = "bisect forward";
        "[fullscreen] <A-l>" = "bisect backward";
        "[fullscreen] <C-s>" = "search forward";
        "[fullscreen] <C-r>" = "search backward";
        "[fullscreen] p" =  "  snap_to_page";
        " [fullscreen] i" = " toggle_index" ;
        " [fullscreen] <C-i>" = "toggle_index";
        "[fullscreen] <Tab>" = "toggle_index";
        "[fullscreen] <A-s>" = "toggle_statusbar";
        "[fullscreen] <A-i>" = "focus_inputbar";
        "[fullscreen] d"  = "toggle_page_mode" ;
        " [fullscreen] + " = "zoom in" ;
        " [fullscreen] - " = "zoom out";
        "[fullscreen] = " = "  zoom in";
        # status bar will obscure last item in index mode
        "[index] <A-s>" = "toggle_statusbar";
        "[index] q" = " toggle_index";
        " [index] i" = " toggle_index";
        " [index] <C-p>" = "navigate_index up";
        "[index] <C-h>" = "navigate_index up";
        "[index] <BackSpace>" = "navigate_index up";
        "[index] <C-n>" = "navigate_index down";
        "[index] <A-v>" = "navigate_index up";
        "[index] <C-v>" = "navigate_index down";
        "[index] \<"  = "navigate_index top";
        "[index] \>" = "navigate_index bottom";
        "[index] <A-\<>" = "navigate_index top";
        "[index] <A-\>>" = "navigate_index bottom";
        "[index] <C-b>" = "navigate_index collapse";
        "[index] <C-f>" = "navigate_index expand";
        "[index] <C-i>" = "navigate_index expand-all";
        "[index] <A-i>" = "navigate_index collapse-all";
        "[index] <Up>" = "navigate_index up";
        "[index] <Down>" = "navigate_index down";
        "[index] <Left>" = "navigate_index collapse";
        "[index] <Right>" = "navigate_index expand";
        "[index] <C-m>" = "navigate_index select";
        "[index] <Space>" = "navigate_index select";
        "[index] <Return>" = "navigate_index select";
        "[index] <C-j>" = "navigate_index select";
        "[index] <Esc>" = "toggle_index";
        "[index] <C-[>" = "toggle_index";
        "[index] <C-g>" = "toggle_index";
        "[index] <C-c>" = "toggle_index";
        "[presentation] i" =  "toggle_index";
        "[presentation] r" = " navigate next";
        "[presentation] <Down>" = "navigate next";
        "[presentation] <Right>" = "navigate next";
        "[presentation] <PageDown>" = "navigate next";
        "[presentation] <Space>" = "navigate next";
        "[presentation] l" = " navigate previous";
        "[presentation] <Left>" = "navigate previous";
        "[presentation] <Up>" = "navigate previous";
        "[presentation] <PageUp>" = "navigate previous";
        "[presentation] <S-Space>" = "navigate previous";
        "[presentation] <BackSpace>" = "navigate previous";
        "[presentation] <F5>" = "toggle_presentation";
        "[presentation] q" = " toggle_presentation" ;
        " [presentation] <C-h>" = "navigate previous";
        "[presentation] <M-v>" = "navigate previous";
        "[presentation] <C-v>" = "navigate next";
        "[presentation] <A-\<>" = "goto top";
        "[presentation] <A-\>>" = "goto bottom";
      }; 		  
    };	   
    
  };
}
