#!/usr/bin/env bash

rm -rf build

cp -rf src build

cd build

echo Running vlna to correct czech spelling

touch all.log

for filename in *.tex; do
    iconv -f UTF-8 -t ISO-8859-2 "$filename" -o "$filename" >> all.log 2>&1
    vlna -l -m -n  "$filename" >> all.log 2>&1
    iconv -f ISO-8859-2 -t UTF-8 "$filename" -o "$filename" >> all.log 2>&1
  done

rm *~

echo Compiling latex to pdf

time latexmk -pdf -f -bibtex -interaction=nonstopmode >> all.log 2>&1

mv *.pdf ../out.pdf
