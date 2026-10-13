# Homebrew fooyin (development HEAD)

Unofficial Homebrew tap for building [fooyin](https://github.com/fooyin/fooyin) from the latest commit on its upstream **master** branch.

## Install

```sh
brew tap Froio/fooyin
brew install --HEAD fooyin
```

Launch using `open "$(brew --prefix fooyin)/fooyin.app"` or the `fooyin` command.

## Update to the latest upstream commit

```sh
brew update
brew reinstall --HEAD fooyin
```

HEAD installs are source builds, not prebuilt bottles. Homebrew does not automatically reinstall whenever upstream commits change.

## Notes

- macOS support is experimental upstream; this formula has not yet been verified with a successful macOS build.
- A recent Xcode Command Line Tools installation with C++23 support is required.
- Upstream uses **master**, not main.
- If configuration or compilation fails, open an issue with the complete build log.
