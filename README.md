# Dockerized Jira Confluence Postgres Crackable
Docker deployment of Jira &amp; Confluence Crackable alongside Postgres as an external DB

## Docker Compoe Configuration

### Providing binary installation files

You should provide binary installation files of Confluence and Jira in ./Confluence and ./Jira and specify the name in both confluence and jira services in build/args section of docker_compose.yml file.

**Copy the full .bin file name and paste it in build/args section and replace `<Confluence-Binary-File.bin>` and `<jira-Binary-File.bin>` with file names in docker_compose.yml file.**

**Remember to put Confluence binary file in ./Confluence and Jira binary file in ./Jira**

You can download binary installation files from here:
- [Confluence installers archieve](https://www.atlassian.com/software/confluence/download-archives)
- [Jira installers archieve](https://www.atlassian.com/software/jira/download-archives)

### Setting up DB credentials
Change `POSTGRES_USER` (replace `dbuser`) and `POSTGRES_PASSWORD` (replace `<DBPassword>`) enviroments in postgres service with your specified credentials.
If you change `POSTGRES_USER` value you have to change it in **./Postgres/initial.sql** file too(Replacing all `dbuser` values with specified username).

- **The volumes in docker-compose.yml file will save container datas inside `/srv/confluence/data` , `/srv/jira/data` and `/srv/postgres/data` dirs**
