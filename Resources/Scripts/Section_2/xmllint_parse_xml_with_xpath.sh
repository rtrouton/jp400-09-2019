#!/bin/bash

#Use xmllint to get the name of the second department in Jamf Pro, using downloaded XML.
xmllint -xpath "/departments/department[2]/name/text()" ~/Desktop/departments.xml