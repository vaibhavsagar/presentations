#!/usr/bin/env bash

pandoc --standalone -t revealjs -V theme:simple presentation.md -o index.html
