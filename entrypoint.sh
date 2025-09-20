#!/bin/sh

env | grep '^ACTIONS_' >> "$GITHUB_ENV"
