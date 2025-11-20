FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y wget unzip

# Download GoPhish
WORKDIR /app
RUN wget -O gophish.zip https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
RUN unzip gophish.zip
RUN chmod +x gophish

# Create config file
RUN echo '{' > config.json
RUN echo '  "admin_server": {' >> config.json
RUN echo '    "listen_url": "0.0.0.0:8080",' >> config.json
RUN echo '    "use_tls": false,' >> config.json
RUN echo '    "allowed_hosts": ["*"]' >> config.json
RUN echo '  },' >> config.json
RUN echo '  "phish_server": {' >> config.json
RUN echo '    "listen_url": "0.0.0.0:8080",' >> config.json
RUN echo '    "use_tls": false' >> config.json
RUN echo '  },' >> config.json
RUN echo '  "db_name": "sqlite3",' >> config.json
RUN echo '  "db_path": "gophish.db",' >> config.json
RUN echo '  "migrations_prefix": "db/db_",' >> config.json
RUN echo '  "contact_address": "",' >> config.json
RUN echo '  "logging": {' >> config.json
RUN echo '    "filename": ""' >> config.json
RUN echo '  }' >> config.json
RUN echo '}' >> config.json

# Start GoPhish
CMD ["./gophish"]
