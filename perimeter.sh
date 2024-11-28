#!/bin/bash
read -p "Length of Rectangle: " length
read -p  "Width of Rectangle: " width
perimeter=$((2 * ($length + $width)))
echo "Perimter of the rectangel is : "$perimeter
