#!/usr/bin/env sh

cd "$(dirname "$0")" || exit

echo Installing dotfiles from "$PWD"

# shellcheck disable=SC2010
ls -1 |
grep -v LICENSE |
grep -v README |
grep -v install.sh |
grep -v update.sh |
while read -r file
do
  header=$(head -n 1 "$file")
  # shellcheck disable=SC2086
  set $header

  if [ "$3" != "for" ] || [ "$5" != "users" ]
  then
    echo "$file": mal-formatted header, skipped
    continue
  fi

  dest=$HOME/$2
  ucat=$4

  case "$ucat" in
    regular)
      if [ "$USER" = "root" ]
      then
        echo "$file": for regular users only, skipped
        continue
      fi
      ;;
    admin)
      if [ "$USER" != "root" ]
      then
        echo "$file": for admin users only, skipped
        continue
      fi
      ;;
    all)
      ;;
    *)
      echo "$file": unknown user category, skipped
      continue
  esac

  echo "$file": installing file to "$dest"
  cp "$file" "$dest"
done

echo Done.
