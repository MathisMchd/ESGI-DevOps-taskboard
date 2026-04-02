# Image officielle légère
FROM postgres:16-alpine


# Variables d'environnement par défaut (peuvent être override)
ENV POSTGRES_DB=app_db \
    POSTGRES_USER=app_user \
    POSTGRES_PASSWORD=secure_password

# Copier les scripts d'initialisation
# (création de tables, extensions, etc.)
COPY ./init /docker-entrypoint-initdb.d/

# Copier config custom (optionnel)
COPY ./postgresql.conf /etc/postgresql/postgresql.conf

# Exposer le port PostgreSQL
EXPOSE 5432

# Commande custom avec config
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]