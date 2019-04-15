#!/bin/sh

release_ctl eval --mfa "PackagesBot.ReleaseTasks.migrate/1" --argv -- "$@"
