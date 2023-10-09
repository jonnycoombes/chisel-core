#!/usr/bin/env zsh

ansiGreen='\033[0;32m'
ansiLightGrey='\033[1;37m'
ansiNoColour='\033[0m'

# muted pushd
pushd() {
  command pushd "$@" >/dev/null
}

# muted popd
popd() {
  command pushd "$@" >/dev/null
}

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

cd "$(dirname "$0")"

main() {

	CURRENT_BRANCH=`git branch --show-current`

	echo -e "$ansiGreen"
	echo 'Creating baseline benchmarking for' $CURRENT_BRANCH '(lexer)'
	echo -e "$ansiNoColour"
	cargo bench --bench lexing -- --save-baseline $CURRENT_BRANCH --verbose

	echo -e "$ansiGreen"
	echo 'Creating baseline benchmarking for' $CURRENT_BRANCH '(parser - DOM)'
	echo -e "$ansiNoColour"
	cargo bench --bench dom_parsing -- --save-baseline $CURRENT_BRANCH --verbose

	echo -e "$ansiGreen"
	echo 'Creating baseline benchmarking for' $CURRENT_BRANCH '(parser - SAX)'
	echo -e "$ansiNoColour"
	cargo bench --bench sax_parsing -- --save-baseline $CURRENT_BRANCH --verbose
}

main "$@"
