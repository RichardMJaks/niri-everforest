cd $HOME/Documents/dotfiles
if [ ! -d state ]; then
  mkdir state
fi

echo "Listing .local/state"
ls $HOME/.local/state/ | grep noctalia

echo "Listing .local/state/noctalia"
ls $HOME/.local/state/noctalia

echo "Listing .local/state/noctalia.bkp"
ls $HOME/.local/state/noctalia.bkp

read -p "Proceed? (y/N) " proceeding

if [ "$proceeding" != "y" ]; then
  echo "User decided not to proceed."
  exit 1
fi

# If backup does not exist yet, create it
# I know it is wrong way to do it, but I need this script just once
# because I screwed up the ln last time
if [ ! -d $HOME/.local/state/noctalia.bkp ]; then
  echo "Backing up $HOME/.local/state/noctalia"
  mv $HOME/.local/state/noctalia $HOME/.local/state/noctalia.bkp
fi

rm $HOME/.local/state/noctalia -r

if [ -e state/noctalia ] || [ -L state/noctalia ]; then
  ls -ld state/noctalia
  read -p "state/noctalia exists, delete it and continue? (y/N) " prompt
  [ "$prompt" = "y" ] || exit 1
  rm -r state/noctalia
fi

# Copy the backup to ensure that we have the correct config
echo "Copying backup to repo"
rm state/noctalia -r
cp $HOME/.local/state/noctalia.bkp state/noctalia -r

# Symlink it FROM this repo to the correct place
echo "Creating symlink from $HOME/Documents/dotfiles/state/noctalia to $HOME/.local/state/noctalia"
ln -s $HOME/Documents/dotfiles/state/noctalia $HOME/.local/state/noctalia

# Push it to repo
git add state/
git commit -m "fix(noctalia): sync .local/state/noctalia to repo"
git push

# Remember kids, don't forget to create backups
