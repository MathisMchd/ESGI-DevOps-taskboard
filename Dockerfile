# Image officielle légère
FROM postgres:16-alpine


COPY ./init /docker-entrypoint-initdb.d/

# Copier config custom (optionnel)
COPY ./postgresql.conf /etc/postgresql/postgresql.conf

# Exposer le port PostgreSQL
EXPOSE 5432

# Commande custom avec config
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]