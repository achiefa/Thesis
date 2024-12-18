#!bin/bash
#
# Check the spelling of the LaTeX file and fail if there are errors.
#
# Spell checker with hunspell
# -d en_GB: British English
# -t: TeX mode
# -a: Morphological analysis
# -l: List only misspelled words
# -d dict/words: Adds custom dictionary located in dict/words
hunspellOutput="$(find . -type f -name '*.tex' | xargs hunspell -d en_GB -t -a -l -p dict/words)"