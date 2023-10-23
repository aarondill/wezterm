# WezTerm Configuration

This is my WezTerm configuration. No guarantees are made about changes. I _WILL_ push to main, I **WILL** change random things whenever I feel like it.

To install the term info database, run this command:

```shell
> tempfile="$(mktemp)" \
  && curl -o "$tempfile" "https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo" \
  && tic -x -o "/lib/terminfo/w/wezterm" "$tempfile" \
  && rm -f -- "$tempfile"
```
