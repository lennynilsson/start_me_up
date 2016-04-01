#!/usr/bin/env bash

# set_me_up.sh
# Version: 0.0.1
# Author: Lenny Nilsson
# Usage: ./set_me_up.sh

say -v Daniel "I don't want to be a product of my environment. I want my environment to be a product of me."

sudo xcode-select --install

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/versions
brew cask install java7
brew install docker
brew install wget vim git node maven gradle android-sdk
brew cask install google-chrome android-studio textwrangler

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

printf "\n\nThe file $HOME/$VM_OPTIONS contains all AndroidStudio settings.\n"
printf "\nThe file $HOME/$ANDROID_STUDIO_ENV contains all environment variables.\n\n\n"

printf "\n\nWhere we go from there is a choice I leave to you.\n\n"
say -v Daniel "Where we go from there is a choice I leave to you."

# Update Android SDK
android update sdk --no-ui --filter platform,platform-tool,tool
