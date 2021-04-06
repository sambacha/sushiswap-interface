#!/usr/bin/env bash
# see https://github.com/yarnpkg/yarn/issues/696
echo $(cat package.json | jq 'del(.devDependencies)') > prod.json
# or
# yarn remove $(cat package.json | jq -r '.devDependencies | keys | join(" ")')

