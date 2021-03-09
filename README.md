# mac-setup

Run the following command on new mac

```
bash <(curl -H "Cache-Control: no-cache, no-store, must-revalidate" https://raw.githubusercontent.com/ygnr/mac-setup/master/setup.sh)
```

## Install Vscode extensions

```
cd $HOME/Code
chmod +x ./vscode/mac-setup/install.sh
./vscode//mac-setup/install.sh
```

## Setup ssh

```
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
```
First, check to see if your ~/.ssh/config file exists in the default location.

```
open ~/.ssh/config
> The file /Users/you/.ssh/config does not exist.
```

If the file doesn't exist, create the file.
```
touch ~/.ssh/config
```

Open your ~/.ssh/config file, then modify the file, replacing ~/.ssh/id_ed25519 if you are not using the default location and name for your id_ed25519 key.
Note: If you chose not to add a passphrase to your key, you should omit the UseKeychain line.

```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

Add your SSH private key to the ssh-agent and store your passphrase in the keychain. If you created your key with a different name, or if you are adding an existing key that has a different name, replace id_ed25519 in the command with the name of your private key file.

```
ssh-add -K ~/.ssh/id_ed25519
```

Copy pubkey to clipboard
```
pbcopy < ~/.ssh/id_ed25519.pub
```

## Install node
```
nvm install node
```