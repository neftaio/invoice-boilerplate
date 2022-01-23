#! /usr/bin/env bash

help ()
{
    echo "Execute pandoc/latex invoice compilation"
    echo
    echo "Syntax: ./compile.sh [-h|t|d]"
    echo "options:"
    echo "h     Print this help"
    echo "t     Template file (Defult: template.tex)"
    echo "d     Definitions file (Default: details.yml)"
    echo
}

template=template.tex

details=details.yml

echo -e "Tex Compilation Start"
while getopts ht:d: option; do
    case $option in
        h)
            help
            exit;;
        t)
            template=${OPTARG};;
        d)
            details=${OPTARG};;
    esac
done

if [[ ! -f $template ]]; then
    echo "Template file ${template} does not exist" && exit 1
fi

if [[ ! "$template" =~ \.(tex) ]]; then
    echo "Template file ${template} not .tex extension" && exit 1
fi

if [[ ! -f $details ]]; then
    echo "Details file ${details} does not exist" && exit 1
fi

if [[ ! "$details" =~ \.(yml) ]]; then
    echo "Template file ${details} not .yml extension" && exit 1
fi

source $HOME/.bashrc

pandoc $details -o output.pdf --template=$template --pdf-engine=xelatex
