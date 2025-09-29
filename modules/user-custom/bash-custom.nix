{lib , pkgs , config  ,  ... } :
let
  cfg = config.bash-custom;
in  {
  options.bash-custom  = {
    enable  = lib.mkEnableOption "enable bash module " ;
  };
config =  lib.mkIf  cfg.enable   {
  programs.bash.enable = true;  	     
  programs.bash.enableCompletion = true;
  programs.bash.historyIgnore = [ "ls" "cd" "exit"];
  programs.bash.initExtra = ''

[[ $- == *i* ]] && source $(blesh-share)/ble.sh  --noattach

# Source global definitions
if [ -f /etc/bashrc ]; then
. /etc/bashrc
fi
export PATH=/home/platoali/bin:$PATH
# User specific aliases and functions
alias leila='ssh -p 4022 leila.1024s.com'
alias ec='emacsclient -c'
alias msh='mosh --ssh="ssh -p 14000" '
#xmodmap -e "clear mod5"
#xmodmap -e "keycode 108 = Alt_L"
#xmodmap .xmodmap
#xmodmap -e "keycode 108 = Alt_R Meta_R Alt_R Meta_R"
#xmodmap -e "keycode 135 = ISO_Level3_Shift"
export PATH="$HOME/.local/bin:$HOME/bin/:$PATH"
# alias emacs='emacs -nw'
# stack auto complete
# eval "$(stack --bash-completion-script stack)"

#[ -f "/home/platoali/.ghcup/env" ] && source "/home/platoali/.ghcup/env" # ghcup-env
#[ -f "/home/platoali/.ghcup/env" ] && source "/home/platoali/.ghcup/env" # ghcup-env
# [ -f "/home/platoali/.ghcup/env" ] && source "/home/platoali/.ghcup/env" # ghcup-env
#[ -f "/usr/share/fzf/key-bindings.bash" ] && source "/usr/share/fzf/key-bindings.bash"
export EDITOR="emacsclient -c"
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
GIT_PROMPT_ONLY_IN_REPO=1
source $HOME/.bash-git-prompt/gitprompt.sh
fi

if [ -f "$HOME/finance/main.journal" ]; then
export  LEDGER_FILE="$HOME/finance/1402.journal"
fi

export GCM_CREDENTIAL_STORE=gpg
[[ $BLE_VERSION ]] && ble-attach

# Ctr-backspace to delete a word.
ble-bind -f 'C-M-?' kill-backward-cword
'';
};
}
