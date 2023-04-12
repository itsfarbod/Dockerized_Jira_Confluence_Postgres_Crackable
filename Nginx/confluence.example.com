server {
    server_name confluence.example.com;
    
    # HTTP configuration
    
    location / {
        client_max_body_size 100m;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://localhost:8090;
    }
    proxy_connect_timeout 3600s;
	  proxy_send_timeout 3600s;
	  proxy_read_timeout 3600s;


}
