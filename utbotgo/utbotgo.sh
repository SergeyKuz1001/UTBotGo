#!/usr/bin/env bash
set -e
utbotgo_dir=##utbotgo_dir # This variable will be initialized after installing
source "$utbotgo_dir/.env"
help_message='
Usage: utbotgo <command>

Description:
    `utbotgo` is utility for generating unit-tests for Go projects. Now it
    generate unit-tests for specific functions by using projects `gollvm` and
    `klee`.

Commands:
    init
        Initialize current directory for generating unit-tests. Current
        directory must be directory with Go package.
    generate
        Generate unit-tests for functions which specified in file
        `utbotgo/config.yml`.
    test
        Run generated unit-tests. It does the same as `utbotgo generate`
        followed by `go test -v`.
    update_answers
        Accept current results of unit-tests as right.
    clean
        Remove all objects which were generated by this utility.
'
vline() {
  yes - | head -80 | tr -d '\n'
}
if (( $# != 1 )); then
    echo 'ERROR: must be only one command-line argument'
    vline
    echo -n "$help_message"
else
    case $1 in
      init)
        mkdir -p utbotgo
        cp "$utbotgo_dir/workspace_files/init_config.yml" utbotgo/config.yml
        echo 'Initialization continued successfully.'
        echo 'Configuration defined in file `utbotgo/config.yml`.'
        ;;
      generate | test | update_answers | clean)
        docker run \
            --rm \
            -v "$PWD":/workspace \
            -v "$utbotgo_dir":/utbotgo \
            -w /workspace \
            utbotgo:"$UTBOTGO_VERSION" \
            /utbotgo/utils/bin/config_parser "$1"
        ;;
      *)
        echo 'ERROR: unknown command'
        vline
        echo -n "$help_message"
        ;;
    esac
fi
