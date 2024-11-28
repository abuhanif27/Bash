#!/bin/bash
read -p "Radius of the circle: " radius
area=$(echo "sale=2; 3.1416 * $radius * $radius"|bc)
printf "Area of the circle is : %.2f\n" "$area"
