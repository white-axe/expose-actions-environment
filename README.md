This is an action for GitHub Actions to expose the values of the ACTIONS_ environment variables (e.g. ACTIONS_RUNTIME_TOKEN) to a composite action. It's essentially the same thing as [crazy-max/ghaction-github-runtime](https://github.com/crazy-max/ghaction-github-runtime) except it doesn't use Node.js, so it can be used in composite actions that run in a container that can't run Node.js.

Due to [a bug in the GitHub Actions runtime](https://github.com/actions/runner/issues/3046), these environment variables are not exposed to composite actions, so this action, for example, is unable to get these environment variables:

```yaml
on: push
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: |
        # This won't print anything because the ACTIONS_RUNTIME_TOKEN environment variable isn't exposed
        echo "$ACTIONS_RUNTIME_TOKEN"
```

To fix it, run the white-axe/expose-actions-environment action beforehand:

```yaml
on: push
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: white-axe/expose-actions-environment@v1
      - run: |
        # This environment variable will exist this time
        echo "$ACTIONS_RUNTIME_TOKEN"
```
