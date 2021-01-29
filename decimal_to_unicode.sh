#!/bin/bash

#################################################################################~
#
# Pass a base-10 number, get the corresponding unicode character back.
# E.g.
# 
#  $  ./decimal_to_unicode.sh 232
#  >  è
#
# Handles leading zeros in the input.
# E.g.
# 
#  $  ./decimal_to_unicode.sh 0232
#  >  è
#
# N.B. The only output on stdout is the desired character, no newline character.
#
# I plan to use this to power keyboard shortcuts that enable typing French on an English keyboard layout.
# I memorized the ms windows keyboard shortcut of ALT + NNNN a very long time ago. I would like to be able
# to use that on my current desktop environment (cinnamon on debian). It sounds tedious but I swear it is
# fast once you get used to it. 
#
###############################################~

# Stops further execution of script if there is an error
set -e;

# The prefix for our unicode escape sequence. The backslash must be escaped with another backslash!
# Here is a relevant excerpt from 'man bash':
#
# \uHHHH
# the Unicode (ISO/IEC 10646) character whose value is the hexadecimal value HHHH (one to four hex digits)
prefix=\\u;

# Converts decimal into hex
# E.g. 232 -> e8
hex=$(printf "%x" $((10#$1)));

# Outputs the corresponding character to stdout
echo -ne $prefix$hex;

# The whole script could be replaced with the following one-liner:
# echo -ne \\u$(printf "%x" $((10#$1)));
# But this way is easier to understand.

exit 0;

