# Dock
defaults write -g com.apple.dock.show-recents -bool false
defaults write -g com.apple.dock.autohide -bool true

# Finder
defaults write com.apple.finder FXPreferredViewStyle Nlsv

# Mouse and trackpad
defaults write -g com.apple.mouse.tapBehavior -bool false
defaults write -g com.apple.trackpad.tapBehavior -bool true

# Disable auto capitalization and automatic periods
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticTextCompletionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# Function keys
defaults write -g com.apple.keyboard.fnState -bool true

# Repeating keys
defaults write -g ApplePressAndHoldEnabled 0

echo "Restart in order for the changes to have effect..."
