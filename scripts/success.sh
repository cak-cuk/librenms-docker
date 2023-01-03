#!/bin/bash

set -x

curl "$GITHUB_API_URL/statuses/$GIT_COMMIT" \
              -H "Content-Type: application/json" \
              -H "Accept: application/vnd.github+json" \
              -H "Authorization: token $GITHUB_TOKEN" \
              -X POST \
              -d "{\"state\": \"success\",\"context\": \"continuous-integration/jenkins\", \"description\": \"Jenkins\", \"target_url\": \"$BUILD_URL\"}"
