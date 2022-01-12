#!/usr/bin/env sh

me="${0##*/}"

case "${1}" in
  install)
    [ "$(id -u)" -ne 0 ] && printf '%s\n' "${me}: run as root." && exit 1
    cp bin/tor-ctrl /usr/local/bin/
    for mandir in "/usr/local/man/man8" "/usr/local/share/man/man8" "/usr/share/man/man8"; do
      [ -d "${mandir}" ] && cp man/tor-ctrl.8 "${mandir}" && break
    done
  ;;
  man)
    command -v pandoc >/dev/null || printf '%s\n' "Install 'pandoc' to create manual pages"
    pandoc -s -f markdown-smart -t man docs/tor-ctrl.8.md -o man/tor-ctrl.8
  ;;
  *) printf '%s\n' "Usage: [install|man|help]"
esac