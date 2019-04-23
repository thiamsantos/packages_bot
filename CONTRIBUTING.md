# Contributing to melpa_telegram_bot
First off, thanks for taking the time to contribute!

Now, take a moment to be sure your contributions make sense to everyone else.
These are just guidelines, not rules.
Use your best judgment, and feel free to propose changes to this document in a pull request.

## Reporting Issues
Found a problem? Want a new feature? First of all see if your issue or idea has [already been reported](https://github.com/thiamsantos/melpa_telegram_bot/issues).
If don't, just open a [new clear and descriptive issue](https://github.com/thiamsantos/melpa_telegram_bot/issues/new).

## Submitting pull requests
Pull requests are the greatest contributions, so be sure they are focused in scope, and do avoid unrelated commits.
And submit your pull request after making sure that all tests pass and they are covering 100% of the code.

- Fork it!
- Clone your fork: `git clone https://github.com/<your-username>/melpa_telegram_bot`
- Navigate to the newly cloned directory: `cd melpa_telegram_bot`
- Create a new branch for the new feature: `git checkout -b my-new-feature`
- Install the tools necessary for development: `mix deps.get`
- Make your changes.
- Commit your changes: `git commit -am 'Add some feature'`
- Push to the branch: `git push origin my-new-feature`
- Submit a pull request with full remarks documenting your changes.

## Githooks

We use githooks to ensure file consistency. Make sure to download and install the hooks after cloning the repo.

```sh
$ curl -o /usr/local/bin/git-hooks https://raw.githubusercontent.com/icefox/git-hooks/master/git-hooks
$ chmod +x /usr/local/bin/git-hooks
$ git-hooks --install
```

## Running locally
To install and run the bot locally:

- Clone the repo: `git clone https://github.com/thiamsantos/melpa_telegram_bot`
- Install the [githooks](#githooks)
- Navigate to the newly cloned directory: `cd melpa_telegram_bot`
- Run `mix deps.get`
- Run `docker-compose up` to mount the database instance
- Run `mix run --no-halt` to run the bot

## Testing
Every time you write a test, remember to answer all the questions:

1. What are you testing?
2. What should it do?
3. What is the actual output?
4. What is the expected output?
5. How can the test be reproduced?

