#!/bin/bash

# Install script for the project

# Install vimrc
# Ask user if they want to install the vimrc
# If 'Y' or 'y', copy the vimrc file to the user's home directory
read -p "Do you want to install the vimrc? (Y/n): " install_vimrc

if [[ "$install_vimrc" == "Y" || "$install_vimrc" == "y" || -z "$install_vimrc" ]]; then
    echo "Installing vimrc..."
    # Check if the vimrc already file exists
    
    if [ -f ~/.vimrc ]; then
        echo "Warning: ~/.vimrc already exists. It will be overwritten."
        read -p "Do you want to continue? (Y/n): " confirm
        if [[ "$confirm" != "Y" && "$confirm" != "y" && -n "$confirm" ]]; then
            echo "Aborting vimrc installation."
            exit 1
        fi
    else
        echo "No existing ~/.vimrc found. Proceeding with installation."
        # Create the .vimrc file
        touch ~/.vimrc
    fi
    cp vimrc ~/.vimrc
    echo "vimrc installed successfully."
else
    echo "Skipping vimrc installation."
fi
echo

# Ask user if install Copilot in vim
read -p "Do you want to install Copilot in vim? (Y/n): " install_copilot
if [[ "$install_copilot" == "Y" || "$install_copilot" == "y" || -z "$install_copilot" ]]; then
    echo "Installing Copilot in vim..."

    ### Install dependencies
    sudo apt update
    sudo apt install vim

    # Install nodejs
    # Download and install nvm:
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    # in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"

    # Download and install Node.js:
    nvm install 22

    # Verify the Node.js version:
    node -v # Should print "v22.17.0".
    nvm current # Should print "v22.17.0".

    # Verify npm version:
    npm -v # Should print "10.9.2".

    ### Install copilot.vim
    git clone --depth=1 https://github.com/github/copilot.vim.git \
        ~/.vim/pack/github/start/copilot.vim

    
    echo "Copilot installed successfully."
else
    echo "Skipping Copilot installation."
fi
echo

# Set up bash git prompts
echo "Setting up bash git prompt..."
# Clone the bash-git-prompt repository
if [ -d ~/.bash-git-prompt ]; then
    echo "Warning: ~/.bash-git-prompt already exists."
else
    git clone --depth=1 https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt
fi

# Add to bashrc if not already present
if ! grep -q "bash-git-prompt" ~/.bashrc; then
    echo "source ~/.bash-git-prompt/gitprompt.sh" >> ~/.bashrc
    echo "Bash git prompt set up successfully."
else
    echo "Bash git prompt already set up in ~/.bashrc."
fi
