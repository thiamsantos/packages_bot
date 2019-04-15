# PackagesBot

[![Build Status](https://travis-ci.com/thiamsantos/melpa_telegram_bot.svg?branch=master)](https://travis-ci.com/thiamsantos/melpa_telegram_bot)
[![Coverage Status](https://coveralls.io/repos/github/thiamsantos/melpa_telegram_bot/badge.svg?branch=master)](https://coveralls.io/github/thiamsantos/melpa_telegram_bot?branch=master)

## TODO

- [ ] Humanize total downloads response
- [ ] Write Readme
- [ ] Add tests
- [x] Add Credo
- [x] Add CI
- [x] Add coveralls
- [x] Add CD
- [x] Configure GitHooks
- [x] Configure distillery
- [x] Deploy on gigalixir

## Githooks

We use githooks to ensure file consistency. Make sure to download and install the hooks after cloning the repo.

```sh
$ curl -o /usr/local/bin/git-hooks https://raw.githubusercontent.com/icefox/git-hooks/master/git-hooks
$ chmod +x /usr/local/bin/git-hooks
$ git-hooks --install
```
