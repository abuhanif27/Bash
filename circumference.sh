#!/bin/bash
read -p "Enter radius: " radius
circumference=$(echo "scale=2; 2 * 3.1416 * $radius/1"|bc)
echo "Circumference of Circle is : "$circumference
