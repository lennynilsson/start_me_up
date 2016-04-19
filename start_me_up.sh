#!/usr/bin/env bash

# set_me_up.sh
# Version: 0.1.2
# Author: Lenny Nilsson
# Usage: ./set_me_up.sh

printf "\n\nI don't want to be a product of my environment. I want my environment to be a product of me.\n\n"

# Download and install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
    xcode-select --install
fi

# Download and install Homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Tap versions
brew tap caskroom/versions
brew cask install java7
brew install docker
brew install wget vim zsh git node maven gradle android-sdk
brew cask install google-chrome android-studio textwrangler

# Auto-complete for Homebrew
brew install homebrew/completions/brew-cask-completion 
brew install zsh-completions

# File names
VM_OPTIONS=.studio.vmoptions
ANDROID_STUDIO_ENV=android_studio_environment.sh

cat > $HOME/$VM_OPTIONS << "EOL"
-Xms1024m
-Xmx4096m
-XX:MaxPermSize=1024m
-XX:ReservedCodeCacheSize=512m
-XX:+UseCompressedOops
EOL

printf "VM_OPTIONS=$VM_OPTIONS\n" > $HOME/$ANDROID_STUDIO_ENV

cat >> $HOME/$ANDROID_STUDIO_ENV << "EOL"

# Setup Java version
export JAVA_HOME=`/usr/libexec/java_home -v 1.7`

# Export paths
export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK_HOME=/usr/local/opt/android-ndk

# Setup AndroidStudio settings
export STUDIO_VM_OPTIONS=$HOME/$VM_OPTIONS
# Export STUDIO_PROPERTIES
export STUDIO_JDK=$JAVA_HOME

# Export Java binaries
export PATH=$JAVA_HOME/bin:$PATH

# Export Homebrew bin path
export PATH=/usr/local/bin:$PATH
# Export build systems
export PATH=$ANT_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
# Export Android build tools
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/build-tools/$(ls -tr $ANDROID_HOME/build-tools/ | tail -1):$PATH
EOL

# Include Environment variables for bash and zsh
include="\n# AndroidStudio environment includes\nsource \"\$HOME/$ANDROID_STUDIO_ENV\"\n"
printf "$include" >> "$HOME/.bashrc"
printf "$include" >> "$HOME/.zshrc"

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

#Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

#Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

#Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#Show the ~/Library folder
chflags nohidden ~/Library

printf "\n\nThe file $HOME/$VM_OPTIONS contains all AndroidStudio settings."
printf "\nThe file $HOME/$ANDROID_STUDIO_ENV contains all environment variables."
printf "\nAndroid SDK is located here: /usr/local/opt/android-sdk"

# Update Android SDK
printf "\n\nTo update android studio run this:\n"
printf "android update sdk --no-ui --filter platform,platform-tool,tool\n\n"

printf "\nWhere we go from there is a choice I leave to you.\n\n"
