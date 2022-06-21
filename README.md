<div align="center">

# asdf-kumactl [![Build](https://github.com/nutellinoit/asdf-kumactl/actions/workflows/build.yml/badge.svg)](https://github.com/nutellinoit/asdf-kumactl/actions/workflows/build.yml) [![Lint](https://github.com/nutellinoit/asdf-kumactl/actions/workflows/lint.yml/badge.svg)](https://github.com/nutellinoit/asdf-kumactl/actions/workflows/lint.yml)


[kumactl](https://kuma.io) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add kumactl
# or
asdf plugin add kumactl https://github.com/nutellinoit/asdf-kumactl.git
```

deck:

```shell
# Show all installable versions
asdf list-all kumactl

# Install specific version
asdf install kumactl latest

# Set a version globally (on your ~/.tool-versions file)
asdf global kumactl latest

# Now deck commands are available
deck --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/nutellinoit/asdf-deck/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Samuele Chiocca](https://github.com/nutellinoit/)
