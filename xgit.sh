#!/bin/bash

echo "Enter file name: "
read filename
 
echo "Enter commit mssg: "
read commitmssg

echo "Enter origin: "
read origin


git add $filename
git commit -m "$commitmssg"
git push origin $origin

echo pushed new change in $filename with commit message $commitmssg to $origin branch 
