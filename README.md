<<<<<<< HEAD
<<<<<<< HEAD
# PackagesBot
=======
# Melpa Telegram Bot
>>>>>>> docs(readme): add description, contributing, usage and license sections
=======
# Melpa Telegram Bot
>>>>>>> docs(readme): add description, contributing, usage and license sections

[![Build Status](https://travis-ci.com/thiamsantos/melpa_telegram_bot.svg?branch=master)](https://travis-ci.com/thiamsantos/melpa_telegram_bot)
[![Coverage Status](https://coveralls.io/repos/github/thiamsantos/melpa_telegram_bot/badge.svg?branch=master)](https://coveralls.io/github/thiamsantos/melpa_telegram_bot?branch=master)

An inline bot for Telegram that fetches information from [Melpa Emacs Package Repository](melpa.org) and displays it on a nice card-style format.

![bot usage demostration](usage.gif "Usage demostration")

It works by fetching https://melpa.org/archive.json and https://melpa.org/download_counts.json, parsing them and then storing the package information on a database every 1 hour. The database is then used to get the information about the package requested.

## TODO

- [ ] Humanize total downloads response
- [x] Write Readme
- [ ] Add tests
- [x] Add Credo
- [x] Add CI
- [x] Add coveralls
- [x] Add CD
- [x] Configure GitHooks
- [x] Configure distillery
- [x] Deploy on gigalixir

## Contributing

See the [contributing file](CONTRIBUTING.md).

## License

[Apache License, Version 2.0](LICENSE) © [Thiago Santos](https://github.com/thiamsantos)




