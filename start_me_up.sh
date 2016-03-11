#!/usr/bin/env bash

# set_me_up.sh
# Version: 0.0.1
# Author: Lenny Nilsson
# Usage: ./set_me_up.sh

say -v Daniel "Installing command line tools. This requires some user interaction."
sudo xcode-select --install
say -v Daniel "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
say -v Daniel "Installing cask versions"
brew tap caskroom/versions
say -v Daniel "Installing Java 7 as a dependency for Docker"
brew cask install java7
say -v Daniel "Installing Docker"
brew install docker
say -v Daniel "Installing common tools and frameworks"
brew install wget vim git node maven gradle android-sdk
say -v Daniel "Installing common tools and frameworks from casks"
brew cask install google-chrome android-studio textwrangler
say -v Daniel "Updating the Android SDK. This requires some user interaction."
android update sdk --no-ui --filter platform,platform-tool,tool
say -v Daniel "All done! Thank you for waiting."
printf "\n\nAll done! Thank you for waiting.\n\n"