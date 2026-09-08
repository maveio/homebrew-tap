# Mave Homebrew tap

Install the [Mave CLI](https://github.com/maveio/mave-cli):

```sh
brew install maveio/tap/mave
mave auth login
```

The CLI includes its runtime; Elixir and Erlang are not required separately.
Packages support macOS 13+ and Linux with glibc 2.35+, on ARM64 and x86-64.

To update:

```sh
brew update
brew upgrade mave
```

See the [CLI documentation](https://github.com/maveio/mave-cli#readme) for usage
and [security reporting](https://github.com/maveio/mave-cli/blob/main/SECURITY.md).

Licensed under [AGPL-3.0-or-later](LICENSE).
