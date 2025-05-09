# Freelance

A WordPress website built using the [Roots/Bedrock boilerplate.](https://roots.io/bedrock/)

## Setup

Environment Variables:

- Copy the `.env.example` file to `.env` to configure your environment variables.

## Development

```bash
# Start app
docker compose up

# Stop app
docker compose down
```

## Production

The website is deployed via a GitHub Actions workflow when a pull request is merged into the main branch.
