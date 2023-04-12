# Dockerized Jira Confluence Postgres Crackable

Docker deployment of Jira &amp; Confluence Crackable alongside Postgres as an external DB

**First of all clone project to your server and go to project directory**

Then install docker cli on your server

after that, you need to make a sudo user e.g atlassian with sudo access and uid/gid 1000

this is very important to have a user with 1000 ids

then make directories for docker volumes and set permission to user with 1000 id

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

- **The volumes in docker-compose.yml file will save containers datas inside `/srv/confluence/data` , `/srv/jira/data` and `/srv/postgres/data` directories**

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
- change `proxyName` parameter and replace your domain name with `jira.example.com` value.
- Don't change `answers.txt` and `setenv.sh` files, They are modified to install and crack binary files.
- Don't forget to move `atlassian-agent.jar` file to `./Jira` directory.

### Confluence

- Go to `./Confluence` directory.
- Open `server.xml` file and head to `Connector` section.
- change `proxyName` parameter and replace your domain name with `confluence.example.com` value.
- Don't change `answers.txt` and `setenv.sh` files, They are modified to install and crack binary files.
- Don't forget to move `atlassian-agent.jar` file to `./Confluence` directory.

## Running everything

Run `docker compose up -d` in main directory.

## Nginx Reverse proxy with let's encrypt ssl certificate

- Step 1:
  
  Install certboot for obtaining ssl certificate.
  
- Step 2:

  Head to `./Nginx` folder and rename `jira.example.com` and `confluence.example.com` files with your subdomains.
  
  Open these two files and set and replace your subdomains in `server_name` parameter under `server` section.
  
  You should replace `jira.example.com` and `confluence.example.com` with your subdomains.

- Step 3:
  
  move these two files with the name of your subdomains to `/etc/nginx/sites-enabled/` directory

- Step 4:
  
  Run `sudo nginx -t` for check the config files.
  
  If you get an error, reopen the server block file and check for any typos or missing characters.
  
  If you don't, reload nginx with this command `sudo systemctl reload nginx`
  
- Step 5:
  
  Get certificates and config the subdomains by runnig `sudo certbot --nginx` commnd.
  
  After running the above command, if nginx asked you to set a rule for redirecting http connection to https, it is recommended to accept that.
  
  Reload the Nginx with `sudo systemctl reload nginx`
 
  
Now, if your containers be up and running and you head to your subdomains for jira and confluence you will access to your services with https connection.


## Set up

### Set up confluence

