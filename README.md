# Dockerized Jira Confluence Postgres Crackable

Docker deployment of Jira &amp; Confluence Crackable alongside Postgres as an external DB

**First of all make a sudo user e.g atlassian with sudo access and uid/gid 1000**

It is very important to have a user with 1000 id

Clone project to your server and go to project directory

Then install docker cli on your server

Then make directories for docker volumes and set permission to user with 1000 id:

```
sudo mkdir /srv
cd /srv
sudo mkdir confluence
sudo mkdir jira
sudo mkdir postgres
sudo chown -R 1000:1000 /srv
```

## Docker Compoe Configuration

### Providing binary installation files

You should provide binary installation files of Confluence and Jira in ./Confluence and ./Jira and specify the name in both confluence and jira services in build/args section of docker-compose.yml file.

**Copy the full .bin file name and paste it in build/args section and replace `<Confluence-Binary-File.bin>` and `<jira-Binary-File.bin>` with file names in docker-compose.yml file.**

**Remember to put Confluence binary file in ./Confluence and Jira binary file in ./Jira**

You can download binary installation files from here:
- [Confluence installers archieve](https://www.atlassian.com/software/confluence/download-archives)
- [Jira installers archieve](https://www.atlassian.com/software/jira/download-archives)

### Setting up DB credentials

Change `POSTGRES_USER` (replace `dbuser`) and `POSTGRES_PASSWORD` (replace `<DBPassword>`) enviroments in postgres service with your specified credentials.

If you change `POSTGRES_USER` value you have to change it in **./Postgres/initial.sql** file too(Replacing all `dbuser` values with specified username).

- **The volumes in docker-compose.yml file will save containers datas inside `/srv/confluence` , `/srv/jira` and `/srv/postgres/data` directories**

## Postgres Configs

### Credentials 

You have to set DB credentials in docker-compose.yml file for `POSTGRES_USER` and `POSTGRES_PASSWORD` parameters.

You need these information for connecting your Confluence and Jira to your Postgres DB.

**If you change DB username in  docker-compose.yml file then you have to change `dbuser` value in `./Postgres/initial.sql` file**

### Setting up databases needed for Jira and Confluence

Head to the `./Postgres/initial.sql` file and then you can see the Database names and database user and the needed privileges assigned to the database user.

**Postgres Dockerfile will only copy the initial.sql file to the container and initial the database with those queries**

## Jira and Confluence Configs

### atlassian-agent.jar file, the important crack file

You should found the `atlassian-agent.jar` file which is the main crack file for this installation and save it in `./jira` and `./confluence` directories.

**Make sure to rename the agent crack file to `atlassian-agent.jar`**

**Notice that Dockerfile needs this crack file to build the images**

- Additional information about the crack file:

For some reasons i can't share crack file in Github or link it to other sources from here.

But it's kinda easy to find this crack file under the `atlassian-agent.jar` name.

### Jira

- Go to `./Jira` directory.
- Open `server.xml` file and head to `Connector` section.
- Change `proxyName` parameter and replace your domain name with `jira.example.com` value.
- Don't change `answers.txt` and `setenv.sh` files, They are modified to install and crack binary files.
- Don't forget to move `atlassian-agent.jar` file to `./Jira` directory.

### Confluence

- Go to `./Confluence` directory.
- Open `server.xml` file and head to `Connector` section.
- Change `proxyName` parameter and replace your domain name with `confluence.example.com` value.
- Don't change `answers.txt` and `setenv.sh` files, They are modified to install and crack binary files.
- Don't forget to move `atlassian-agent.jar` file to `./Confluence` directory.

## Running everything

Run `docker compose up -d` in main directory.

## Nginx Reverse proxy with let's encrypt ssl certificate

- Step 1:
  
  Install certboot for obtaining ssl certificate.
  [This link is Helpful](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-debian-11)
  
- Step 2:

  Head to `./Nginx` folder and rename `jira.example.com` and `confluence.example.com` files with your subdomains.
  
- Step 3: 

  Open these two files and change `confluence.example.com` and `jira.example.com` under server section with your subdomains.

- Step 4:

  Copy these two files into `/etc/nginx/sites_enabled/`
   
- Step 5:
   
  Get certificates and config the subdomains by runnig `sudo certbot --nginx` commnd.
  
  After running the above command, if nginx asked you to set a rule for redirecting http connections to https, it is recommended to accept that.
  
- Step 6:
  
  Reload the Nginx with `sudo systemctl reload nginx`
 
  
Now, if your containers be up and running and you head to your subdomains for jira and confluence you will access to your services with https connection.


## Set up

It may sound strange, but you have to complete start up setup in a new private tab in your browser or you will get an error in database setup.

### Set up confluence

- Choose production installation

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf1.png)

- Here Copy you Server ID

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf2.png)

- After you copied your Server ID, In your server go to `<github clone>/Confluence/` and run this command:

`java -jar atlassian-agent.jar -d -m <Your Email Here> -n BAT -p conf -o https://confluence.example.com -s <Your Server ID>`

Replace Server ID and subdomain and email in above command.

If you don't have java installed simply install it with:
```
apt update
apt install default-jdk
```

The resault of executing this command is your license. Copy it and paste it in webpage.
- Choose non-clustered option then click next.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf3.png)

- Here you have to configure DB

Default host name is `postgres`

Default port is `5432`

Default DB is `confluencedb`

Default username is `dbuser` if you have not changed it.

And password is the one that you set in docker-compose.yml file.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf4.png)

- Then click on test connection and if it was okay then click next.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf5.png)

- Here you can make a empty site or load it from a backup. Creating an empty template is easy and you can refer to documentation for it, but here i'll load a backup.

Click on Restore From Backup.


![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf6.png)قثبثق

In you server copy your file to `/srv/confluence/restore` directory.

`cp ./<Your backup file> /srv/confluence/restore/`

Then reload the page and you can see the backup file down the page and then click on import.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf7.png)

- Wait till the backup being restored.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf8.png)

- If it was complete then click on next.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf9.png)

- Setup is complete now and then click on start to redirect to login page.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf10.png)

- Now you can see the login page and you can login with your old credentials.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/conf11.png)

### Set up Jira

Like confluence open a new private tab and head to your jira subdomain e.g `https://jira.example.com`

Restoring Jira is different from confluence and it is after installation.

- Select I'll set it up my self option and then click next.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira1.png)

- Check My own DB option and fill out the text bars.

Default Hostname is `postgres`

Default port is `5432`

Default DB is `jiradb`

Default Username is `dbuser`, if you have not changed it.

Enter your password which you set in docker-compose.yml file.

Then click on Test Connection and if everything was okay click on next.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira2.png)

- Here replace your subdomain with `https://jira.example.com` then click on next.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira3.png)

- Copy your server ID
- Go to your server in `<github clone>/Jira/` directory and run this command: 

`java -jar atlassian-agent.jar -d -m <Your Email Here> -n BAT -p jira -o https://jira.example.com -s <Your Server ID>`

Replace Server ID and subdomain and email in above command.

Copy your licence and paste it in webpage.

Save this License because you will need it when you want to restore Jira.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira4.png)

- Select later and click on next.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira5.png)

- Select your language and click on next.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira6.png)

- Installation is complete now.
- Make an example project to have access to jira dashboard for restoring the backup.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira7.png)

### Restoring Jira backup

Open Jira dashboard and on top right corner click on gear icon and click on system.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira8.png)

- In your left side find Restore System option.

- Copy your backup file in `/srv/jira/import/`:

`cp ./<Your Jira backup file> /srv/jira/import`

Select disbale for outgoing email and then click on restore.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira9.png)

- Wait till the end.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira10.png)

- Click on login again to be redirected to login page and there you can login with your old credentials.

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira11.png)

![](https://github.com/itsfarbod/Dockerized_Jira_Confluence_Postgres_Crackable/blob/master/README_images/jira12.png)
