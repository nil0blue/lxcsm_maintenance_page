#!/bin/bash
if [[ -z "${MAINTENANCE_MODE}" ]]; then
  maintenance="0"
else
  maintenance="${MAINTENANCE_MODE}"
fi

echo $maintenance
if [[ $maintenance -eq "1" ]]; then
	echo "Maintenance Mode enabled, renaming file"
	mv /var/www/html/maintenance.html /var/www/html/under_maintenance.html
else
    echo "Not enabled"
fi


