FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget unzip

WORKDIR /app
RUN wget -O gophish.zip https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
RUN unzip gophish.zip
RUN chmod +x gophish

RUN echo '{
    "admin_server": {"listen_url": "0.0.0.0:8080", "use_tls": false},
    "phish_server": {"listen_url": "0.0.0.0:8081", "use_tls": false},
    "db_name": "sqlite3",
    "db_path": "gophish.db",
    "migrations_prefix": "db/db_",
    "contact_address": "",
    "logging": {"filename": ""}
}' > config.json

CMD ["./gophish"]
