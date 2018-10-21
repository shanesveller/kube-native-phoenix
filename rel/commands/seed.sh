#!/bin/sh

release_ctl eval --mfa "KubeNative.ReleaseTasks.seed/1" --argv -- "$@"
