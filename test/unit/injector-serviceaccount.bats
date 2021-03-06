#!/usr/bin/env bats

load _helpers

@test "injector/ServiceAccount: enabled by default" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/injector-serviceaccount.yaml  \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "true" ]
}

@test "injector/ServiceAccount: disable with global.enabled" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/injector-serviceaccount.yaml  \
      --set 'global.enabled=false' \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "false" ]
}
