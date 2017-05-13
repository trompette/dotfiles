#!/usr/bin/env sh

cd `dirname $0`

echo "Updating repository in `pwd`"

ls -1 |
grep -v LICENSE |
grep -v README |
grep -v install.sh |
grep -v update.sh |
while read file
do
	echo -n "  $file: "

	set `head -n 1 "$file"`

	if [ $3 != "for" -o $5 != "users" ]
	then
		echo "mal-formatted header, skipped"
		continue
	fi

	src=$HOME/$2
	ucat=$4

	case "$ucat" in
		regular)
			if [ "$USER" = "root" ]
			then
				echo "for regular users only, skipped"
				continue
			fi
			;;
		admin)
			if [ "$USER" != "root" ]
			then
				echo "for admin users only, skipped"
				continue
			fi
			;;
		all)
			;;
		*)
			echo "unknown user category \"$ucat\", skipped"
			continue
	esac

	echo "updating file from $src"

	cp "$src" "$file"
done

echo "Done."
echo
git status
