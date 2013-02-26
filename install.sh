#!/usr/bin/env sh

cd `dirname $0`

echo "Installing dotfiles from `pwd`"

ls -1 |
grep -v LICENSE |
grep -v README |
grep -v `basename $0` |
while read file
do
	echo -n "$file... "

	set `head -n 1 "$file"`

	if [ $3 != "for" -o $5 != "users" ]
	then
		echo "mal-formatted header... skipped"
		continue
	fi

	dest=$HOME/$2
	ucat=$4

	case "$ucat" in
		regular)
			if [ "$USER" = "root" ]
			then
				echo "for regular users only... skipped"
				continue
			fi
			;;
		admin)
			if [ "$USER" != "root" ]
			then
				echo "for admin users only... skipped"
				continue
			fi
			;;
		all)
			;;
		*)
			echo "unknown user category \"$ucat\"... skipped"
			continue
	esac

	echo -n "copying file to $dest... "

	cp "$file" "$dest"

	echo "done"
done
