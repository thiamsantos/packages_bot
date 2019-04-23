# Package Bot

[![Build Status](https://travis-ci.com/thiamsantos/melpa_telegram_bot.svg?branch=master)](https://travis-ci.com/thiamsantos/melpa_telegram_bot)
[![Coverage Status](https://coveralls.io/repos/github/thiamsantos/melpa_telegram_bot/badge.svg?branch=master)](https://coveralls.io/github/thiamsantos/melpa_telegram_bot?branch=master)

There are two Telegram bots on this project.

A melpa bot that fetches information from [Melpa Emacs Package Repository](http://melpa.org), and a [Hex Packages Repository](https://hex.pm) bot.
Both are inline bots and display package information on a nice card-style format.

![bot usage demonstration](usage.gif "Usage demonstration")

The melpa bot works by fetching https://melpa.org/archive.json and https://melpa.org/download_counts.json, parsing them and then storing the package information on a database every 1 hour. The database is then used to get the information about the package requested.

## Contributing

See the [contributing file](CONTRIBUTING.md).

## License

[Apache License, Version 2.0](LICENSE) © [Thiago Santos](https://github.com/thiamsantos)



