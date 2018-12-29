init_travis() {
    set -e
}

wrapper() {
    set -x
    $*
    set +x
}

install_perl_dependencies() {
    if true
    then
	cpanm --quite --notest 'DBD::mysql~!=4.047'
    fi
}
