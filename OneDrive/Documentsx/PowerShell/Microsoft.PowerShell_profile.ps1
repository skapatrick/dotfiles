# 1. Oh My Posh Prompt (Powerlevel10k-style theme)
oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\powerlevel10k_rainbow.omp.json" | Invoke-Expression

# 2. Icons & Fast Directory Jumping
Import-Module Terminal-Icons
Import-Module z

# 3. PSReadLine Inline Autosuggestions & Keybindings
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -BellStyle None

# Accept the next word of an inline suggestion with Ctrl+RightArrow
Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord
# History substring search with Up/Down arrows (like zsh-history-substring-search)
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# Interactive tab completion menu
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# 4. Useful Aliases & Unix-Style Helper Functions
Set-Alias -Name which -Value Get-Command
Set-Alias -Name g -Value git
Set-Alias -Name grep -Value Select-String
function dotfiles {
    git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @args
}

function ll { Get-ChildItem -Force @args }
function la { Get-ChildItem -Force @args | Format-Wide -AutoSize }
function touch ($file) { if (Test-Path $file) { (Get-Item $file).LastWriteTime = Get-Date } else { New-Item -ItemType File -Path $file | Out-Null } }
function reload { . $PROFILE; Write-Host "Profile reloaded." -ForegroundColor Green }
function myip { (Invoke-WebRequest -Uri "https://api.ipify.org" -UseBasicParsing).Content }