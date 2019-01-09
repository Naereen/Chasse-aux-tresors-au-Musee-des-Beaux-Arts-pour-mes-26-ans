#!/usr/bin/env bash

. ./config.sh

function buildall() {
    # 2. update all.tex
    echo "Updating 'all.tex'..."
    mv -vf all.tex /tmp/

    echo -e "% This is automatically generated with 'build.sh', DO NOT EDIT BY HAND." >> all.tex

    cd ./src/
    for inputfile in $(find . -iname '[[:digit:]]*.tex' | sed s_'./'_''_ | sort -n); do
        echo -e "$inputfile"
        echo -e "\input{./src/$inputfile}" >> ../all.tex
    done
    cd ..

    # build
    pdflatex main.tex && pdflatex main.tex && pdflatex main.tex

    # copy
    echo -e "Copying current 'main.pdf' to 'output/$team.pdf' ..."
    PDFCompress main.pdf
    cp -vf main.pdf output/all.pdf
    pdfinfo output/all.pdf | grep 'Pages'
}


function buildteam() {
    team=$1
    # 2. update all.tex
    echo "Updating 'all.tex'..."
    mv -vf all.tex /tmp/

    echo -e "% This is automatically generated with 'build.sh', DO NOT EDIT BY HAND." >> all.tex

    for inputfile in $(find ./src/ -iname '[[:digit:]]*.tex' | shuf | head -n$NB_QUESTIONS); do
        echo -e "\input{$inputfile}" >> all.tex
    done

    # build
    pdflatex main.tex && pdflatex main.tex && pdflatex main.tex

    # copy
    echo -e "Copying current 'main.pdf' to 'output/$team.pdf' ..."
    PDFCompress main.pdf
    cp -vf main.pdf output/$team.pdf
    pdfinfo output/$team.pdf | grep 'Pages'
}


buildall

for team in $(seq 1 $NB_EQUIPES); do
    buildteam $team
done
