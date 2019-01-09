#!/usr/bin/env bash

. ./config.sh

# 1. update config.tex
echo "Updating 'config.tex'..."
mv -vf config.tex /tmp/

echo -e "% This is automatically generated with 'prebuild.sh', DO NOT EDIT BY HAND." >> config.tex
echo -e '\\newcommand{\\nbequipes}{'${NB_EQUIPES}'}' >> config.tex
echo -e '\\newcommand{\\nbparequipe}{'${NB_PAR_EQUIPE}'}' >> config.tex
echo -e '\\newcommand{\\intervalparequipe}{'${INTERVALE_PAR_EQUIPE}'}' >> config.tex
echo -e '\\newcommand{\\totalnbenigmes}{'${TOTAL_QUESTIONS}'}' >> config.tex
echo -e '\\newcommand{\\nbenigmes}{'${NB_QUESTIONS}'}' >> config.tex

