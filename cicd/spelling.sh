#!bin/bash
#
# Check the spelling of the LaTeX file and fail if there are errors.
#

# Find all .tex files in current directory and subdirectories
tex_files=$(find . -type f -name "*.tex" ! -name "acknowledgments.tex")

# Check if any .tex files are found
if [ -z "$tex_files" ]; then
  echo "No .tex files found."
  exit 0
fi

# Variable to track if any spelling errors are found
errors_found=0

# Loop through each .tex file
for file in $tex_files; do
  echo "Checking spelling for file: $file"
  # Spell checker with hunspell
  # -d en_GB: British English
  # -t: TeX mode
  # -a: Morphological analysis
  # -l: List only misspelled words
  # -d dict/words: Adds custom dictionary located in dict/words
  hunspellOutput="$(hunspell -d en_GB -t -a -l -p dict/words $file)"
  if [ "${hunspellOutput}" != "" ]; then
    # Spelling errors
    echo ""
    echo "======================================================"
    echo "There are spelling errors listed below in file: $file."
    echo "Either fix, or add to \"dict/words\""
    echo "======================================================"
    echo ""
    #hunspell -d en_GB -t -a -l -p dict/words $file
    echo "$hunspellOutput" | tr ' ' '\n' | sort | uniq
    errors_found=1
  else
    echo "Spelling looks good to me in $file"

  fi
done

# Exit with an error if any spelling mistakes were found
if [ $errors_found -eq 1 ]; then
  echo "Spelling errors were found in one or more files. Exiting with error."
  exit 1
else
  echo "All .tex files look good. No spelling errors found."
  exit 0
fi