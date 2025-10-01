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
alias ec='emacsclient -c'
alias sahar='mosh --ssh="ssh -p 14000" sahar '
export PATH="$HOME/.local/bin:$HOME/bin/:$PATH"
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
