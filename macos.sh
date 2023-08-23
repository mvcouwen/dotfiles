# Dock
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock "autohide" -bool "true"
killall Dock

# Mouse
defaults -currentHost write -globalDomain com.apple.mouse.tapBehavior -int 0
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# Function keys
defaults write -g com.apple.keyboard.fnState -bool true
