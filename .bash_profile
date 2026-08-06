# ============================================
# .bash_profile — login shell setup.
# Sources .profile (env/cargo) and .bashrc.
# ============================================
[[ -f "$HOME/.profile" ]] && . "$HOME/.profile"
[[ -n $BASH && $- == *i* && -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
