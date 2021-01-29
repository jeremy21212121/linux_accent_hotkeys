#!/bin/bash

# NB - Doesn't work in web browsers. The focus is lost and does not return. I may be able to work around this.
# It does work in the location bar, just not the page content.

set -e;

# fire keyup for "Alt" in case I didn't let go of it. This allows the semantics to match Windows exactly.
xdotool keyup "alt";

# Pop a small window in the corner to grab keystrokes. We use timeout to kill the process after 800ms,
# you may need to adjust this value depending on how fast you type.
raw_value=$(timeout 0.7s xev -geometry 1x1+0+0 -event keyboard | grep -A4 --line-buffered '^KeyPress' | grep 'XLookupString' | sed -n 's/.*\"\(.\)\"/\1/p');

# By storing multi-line subshell output as a var, it seems to replace the newlines with spaces.
# It would be more efficient to incorporate this into the previous command but I couldn't make it work.
final_value=$(echo -n $raw_value | sed -n 's/ //gp');

# Currently only handling values between 100 and 999. This is all I need, but there is no reason it couldn't
# be extended to a wider range of decimal unicode values.
if [[ ( "$final_value" -gt 99 && "$final_value" -lt 1000 ) ]]
then
	# Convert decimal number to a unicode char and add it to clipboard
	$HOME/projects/bash_scripts/decimal_to_unicode.sh $final_value | xclip -selection "clipboard";
	# Paste accented character into active window.
	# Note this won't work in the terminal, where the command to paste is Ctrl+Shift+V
	xdotool key --clearmodifiers "ctrl+v";
	# We could add some logic to find out if the active window is a terminal and use "ctrl+shift+v" in that case.
	# I don't actually need to use accented characters in the terminal, so it is not a priority.
fi

exit 0;

