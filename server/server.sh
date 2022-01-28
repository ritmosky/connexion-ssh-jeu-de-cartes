#!/bin/bash

script_name=$0

if [ $(whoami) = "root" ]
then
    
else
    echo "Relancer le script avec sudo: sudo $script_name"
fi