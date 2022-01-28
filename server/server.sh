#!/bin/bash

script_name=$0

if [ $(whoami) = "root" ]
then
    echo "Script executé en tant que root."
else
    echo "Relancer le script avec sudo: sudo $script_name"
fi