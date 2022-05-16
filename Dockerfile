# FROM mariadb as builder
FROM mariadb

# That file does the DB initialization but also runs mysql daemon, by removing the last line it will only init
# RUN ["sed", "-i", "s/exec \"$@\"/echo \"not running $@\"/", "/usr/local/bin/docker-entrypoint.sh"]

# needed for intialization
# ENV MYSQL_ROOT_PASSWORD=root
# ENV MYSQL_DATABASE=qod

# MAKE SURE MYSQL_ROOT_PASSWORD is defined in the env before-hand itself!

USER root

# Copy scripts
COPY 1_createdb.sql /tmp1/
COPY 2_authors.sql /tmp1/
COPY 3_genres.sql /tmp1/
COPY 4_quotes_sm.sql /tmp1/

VOLUME [/tmp1]
# Test /var/lib/mysql
# COPY 1_createdb.sql /var/lib/mysql/

# COPY 1_createdb.sql /docker-entrypoint-initdb.d/
# COPY 2_authors.sql /docker-entrypoint-initdb.d/
# COPY 3_genres.sql /docker-entrypoint-initdb.d/
# COPY 4_quotes_sm.sql /docker-entrypoint-initdb.d/

# Need to change the datadir to something else that /var/lib/mysql because the parent docker file defines it as a volume.
# https://docs.docker.com/engine/reference/builder/#volume :
#       Changing the volume from within the Dockerfile: If any build steps change the data within the volume after
#       it has been declared, those changes will be discarded.
# RUN ["/usr/local/bin/docker-entrypoint.sh", "mysqld", "--datadir", "/initialized-db", "--aria-log-dir-path", "/initialized-db"]
# VOLUME [/var/lib/mysql]

# FROM mariadb


# COPY --from=builder /initialized-db /var/lib/mysql
# VOLUME [/var/lib/mysql]
