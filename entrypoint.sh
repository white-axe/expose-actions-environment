#!/bin/sh

env | grep '^ACTIONS_' | tee -a "$GITHUB_ENV"
