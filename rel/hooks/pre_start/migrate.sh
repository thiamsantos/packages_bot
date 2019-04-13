#!/bin/sh

release_ctl eval --mfa "MelpaBot.ReleaseTasks.migrate/1" --argv -- "$@"
