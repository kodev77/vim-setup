### generate new rsa ssh key
ssh-keygen -t rsa -b 4096 -C "youremail@test.com"
cat ~/.ssh/id_rsa.pub

### start and add ssh key into agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

### symlink the file to our repo version
ln -s ~/vim-setup/.vimrc ~/.vimrc
ln -s ~/vim-setup/.vim ~/.vim
