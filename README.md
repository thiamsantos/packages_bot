# Melpa Telegram Bot

This is a Telegram bot that fetches information from [Melpa Emacs Package Repository](melpa.org) and displays on a nice card-style format.

![info box screenshot](melpa-telegram-bot-info-box.png "Package info screenshot")

Made with Elixir and the [Nadia](https://github.com/zhyu/nadia) telegram bot API wrapper.

It works by fetching `melpa.org/archive.json` and `melpa.org/download_counts.json`, parsing them and then storing the package information on a database every 1 hour.

# Usage

To use it, its recommended that you deploy it on a service that provides a database instance, like [Gigalixir](https://www.gigalixir.com).
After deploying, create a database instance and add its address on an Environment Variable like this:

`DATABASE_URL=postgres://postgres:postgres@localhost/melpa_telegram_bot`

Nevertheless if you want to use the bot locally:

- Run `mix deps.get`
- Run `docker-compose up` to mount the database instance
- Run `mix` to run the bot


# Contributing

- Fork this repository
- Clone it to your local machine
- Create a new feature branch with `git checkout -b my-new-feature`
- Make the changes you want
- Push to your forked repo
- Go to Github and send a Pull Request

## TODO

- [ ] Humanize total downloads response
- [x] Write Readme
- [ ] Add tests
- [ ] Add Credo
- [ ] Add CI
- [ ] Configure GitHooks
- [ ] Configure distillery
- [ ] Deploy on gigalixir
