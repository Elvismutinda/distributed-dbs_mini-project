FROM postgres:16

# Install required dependencies for mysql_fdw
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    make \
    default-libmysqlclient-dev \
    postgresql-server-dev-16 \
    && rm -rf /var/lib/apt/lists/*

# Clone and build mysql_fdw
RUN git clone https://github.com/EnterpriseDB/mysql_fdw.git /tmp/mysql_fdw && \
    cd /tmp/mysql_fdw && \
    USE_PGXS=1 make && \
    USE_PGXS=1 make install && \
    rm -rf /tmp/mysql_fdw

# Set the default database name (optional)
ENV POSTGRES_DB=soishop
