#!/bin/bash
read -p "Length of the rectangle: " length
read -p "Wdith of the rectangle: " width

area=$(($length * $width))
echo "Area of Rectangle : "$area
