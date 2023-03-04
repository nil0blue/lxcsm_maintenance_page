# Displaying a Maintenance Page in LXC SM

This repo provides the basic framework for displaying a maintenance page in Liferay Experience Cloud Self Managed (Previously Liferay DXP Cloud) . 

## How to Deploy

To deploy the maintenance page, you will need a LXC SM workspace.
Copy the contents of the `common` folder to the `webserver/configs/{env}` folder in your workspace.
Build and deploy the changes.

Verify the webserver logs, and look for `Running /etc/nginx/scripts/nginxonstart.sh`

When your site needs to enter maintenance mode, go to the Webserver **Environment Variables** page and add the **MAINTENANCE_MODE** environment variable with a value of **1**.

Save the change. This will restart the webserver container and the maintenance page will be served when accessing the webserver URL. 

Note: there will be a very small downtime when this happens, but it will not be noticeable with Rolling Updates.

After you've completed your maintenance activities such as upgrading Liferay, change the **MAINTENANCE_MODE** environment variable to 0 or delete it. The webserver will be restarted and should start serving the backend Liferay content.

## How it Works

The liferay.conf nginx configuration was modified to look for the existence of the `under_maintenance.html` file and return a `503` error. In the absence of the file, the default directives are processed, forwarding the request to the backend.

An error.conf file is supplied which serves the `under_maintenance.html` file in case of a 503 error.

A `maintenance.html` file is supplied in the public folder, which is copied to `/var/www/html` on startup.


A startup script is supplied which checks the **MAINTENANCE_MODE** environment variable and if set to 1, renames the `maintenance.html` file to `under_maintenance.html`, thus triggering the condition to return a 503 in the liferay.conf. 

The startup script is necessary because users do not have privileges to create/move files within the webserver container. 




## Additional Information
This code has been tested in a LXC SM Project with stack version 5.x

If you are going to restore a backup during the maintenance window, make sure the **LCP_BACKUP_RESTORE_STRATEGY** is set to **PREPARE_AND_SWAP**


