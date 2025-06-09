export NONINTERACTIVE=1

# set -v

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Homebrew
if ! brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> /Users/gvanderclay/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/gvanderclay/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle install

# Check to see if oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "Oh My Zsh is already installed."
fi

# Commands for vs code vim
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false # For VSCode Vim
defaults delete -g ApplePressAndHoldEnabled

osascript -e 'tell application "System Preferences" to quit'

# Safari Settings
defaults write com.apple.Safari AutoFillFromiCloudKeychain -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true"

# Dock settings
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array
defaults write com.apple.dock recent-apps -array
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock "autohide-time-modifier" -float "0.3"
defaults write com.apple.dock "show-recents" -bool "false"

# File related settings
defaults write com.apple.finder FXDefaultSearchScope -string SCcf # Search on current folder.
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" # Show file extensions
defaults write com.apple.finder "ShowPathbar" -bool "true" # Show path bar in Finder.
defaults write com.apple.finder FXRemoveOldTrashItems -bool true # Remove Trash items after 30 days.
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true" # Sort folders first in Finder.

# Menu bar settings
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false # Disable flash date separators
defaults write com.apple.menuextra.clock IsAnalog -bool false # Show digital clock
defaults write com.apple.menuextra.clock ShowSeconds -bool true # Show seconds in clock
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true # Show day of week in clock
defaults write "Apple Global Domain" AppleICUForce24HourTime 1 # Show 24 hour time

# Keyboard settings
defaults write "Apple Global Domain" com.apple.keyboard.fnState 1 # Use F1, F2, etc. keys as standard function keys
defaults write NSGlobalDomain AppleKeyboardUIMode -int "2" # Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)

# XCode settings
defaults write com.apple.dt.Xcode "ShowBuildOperationDuration" -bool "true"

# Other
defaults write com.apple.CloudSubscriptionFeatures.optIn "545129924" -bool "false" # Deactivate Apple Intelligence


for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Mail" \
	"Messages" \
	"Photos" \
	"Safari" \
	"SystemUIServer" \
	"Terminal" \
	"XCode" \
	"iCal"; do
	killall "${app}" &> /dev/null
done