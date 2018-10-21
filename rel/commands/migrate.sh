#!/bin/sh

release_ctl eval --mfa "KubeNative.ReleaseTasks.migrate/1" --argv -- "$@"
