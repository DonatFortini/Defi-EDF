# Utiliser l'image PostgreSQL officielle
FROM postgres:14.13

# Définir les variables d'environnement
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=fleet_management

# Copier le fichier SQL dans le conteneur
COPY dump.sql /docker-entrypoint-initdb.d/

# Le dossier /docker-entrypoint-initdb.d/ est automatiquement exécuté par l'image postgres
# lors du premier démarrage du conteneur

# Exposer le port PostgreSQL
EXPOSE 5432

# Configurations PostgreSQL supplémentaires (optionnel)
# Copier un fichier de configuration personnalisé si nécessaire
# COPY postgresql.conf /etc/postgresql/postgresql.conf
