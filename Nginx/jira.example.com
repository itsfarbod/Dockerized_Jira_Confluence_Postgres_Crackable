server {
    server_name jira.example.com;
    
    # HTTP configuration
    
    location / {
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; 
        proxy_pass http://127.0.0.1:8080;
        client_max_body_size 10M;
    }
	proxy_connect_timeout 3600s;
	proxy_send_timeout 3600s;
	proxy_read_timeout 3600s;


}
