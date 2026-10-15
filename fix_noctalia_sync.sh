cd $HOME/Documents/dotfiles
if [! -d state ]; then
  mkdir state
fi
# If backup does not exist yet, create it
# I know it is wrong way to do it, but I need this script just once
# because I screwed up the ln last time
if [ ! -d $HOME/.local/state/noctalia.bkp ]; then
  mv $HOME/.local/state/noctalia $HOME/.local/state/noctalia.bkp
fi

# Copy the backup to ensure that we have the correct config
cp $HOME/.local/state/noctalia.bkp state/noctalia

# Symlink it FROM this repo to the correct place
ln -s $HOME/.local/state/noctalia $HOME/Documents/dotfiles/state/noctalia

# Push it to repo
git add state/
git commit -m "fix(noctalia): sync .local/state/noctalia to repo"
git push

# Remember kids, don't forget to create backups
