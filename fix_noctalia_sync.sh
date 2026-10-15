cd $HOME/Documents/dotfiles
mkdir state
cp $HOME/.local/state/noctalia state/noctalia
mv $HOME/.local/state/noctalia $HOME/.local/state/noctalia.bkp
ln -s $HOME/Documents/dotfiles/state/noctalia $HOME/.local/state/noctalia
git add state/
git commit -m "fix(noctalia): sync .local/state/noctalia to repo"
git push
