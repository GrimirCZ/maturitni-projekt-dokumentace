#!/bin/env bash

rm -rf build

cp -rf src build

cd build

echo Running vlna to correct czech spelling

for filename in *.tex; do
    iconv -f UTF-8 -t ISO-8859-2 "$filename" -o "$filename"
    vlna -l -m -n  "$filename"
    iconv -f ISO-8859-2 -t UTF-8 "$filename" -o "$filename"
  done

rm *~

latexmk -pdf -f -bibtex -interaction=nonstopmode 

mv *.pdf ../out.pdf
