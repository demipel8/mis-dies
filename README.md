# Mis Dies

Give a +1 to a pull request.

## Development

### Build image

```
make build
```

### Run tests

```
make test
```
## Usage

params
 - repo_name: user and name of the repo
 - pull_request: number identifying the pull request in the repo
 - token: The API token for the user thats going to give a +1

```
docker run --rm --env-file ./.env mis-dies <repo_name> <pull_request> <token>
```

Example

```
docker run --rm mis-dies --env-file ./.env user/cool_repo 4 ft68wetf378tf2479
```
