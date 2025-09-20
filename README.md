This is an action for GitHub Actions to get the values of the ACTIONS_ environment variables (e.g. ACTIONS_RUNTIME_TOKEN) from inside of a workflow or composite action.

Due to [a bug in the GitHub Actions runtime](https://github.com/actions/runner/issues/3046), these environment variables are not exposed to workflows or composite actions, so this workflow, for example, is unable to get these environment variables:

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

This action is essentially the same thing as [crazy-max/ghaction-github-runtime](https://github.com/crazy-max/ghaction-github-runtime), except it's a container action instead of a Node.js action, which means it has the following differences:

* It only works in jobs that use Linux. macOS and Windows jobs aren't supported.
* It doesn't use Node.js, so it can be used in jobs that run in a container where the C library is too old for the Node.js binary that the GitHub Actions runtime uses to run Node.js actions.
