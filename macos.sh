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

defaults write com.apple.Safari AutoFillFromiCloudKeychain -bool false
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Safari AutoFillPasswords -bool false

defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array
defaults write com.apple.dock recent-apps -array

# Search on current folder.
defaults write com.apple.finder FXDefaultSearchScope -string SCcf

# Remove Trash items after 30 days.
defaults write com.apple.finder FXRemoveOldTrashItems -bool true


# Show all file extensions.
defaults write -g AppleShowAllExtensions -bool true

defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock ShowSeconds -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true

# Show 24 hour time
defaults write "Apple Global Domain" AppleICUForce24HourTime 1
defaults write "Apple Global Domain" com.apple.keyboard.fnState 1

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
	"iCal"; do
	killall "${app}" &> /dev/null
done