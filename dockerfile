# Base image
FROM alpine:latest

# Metadata
LABEL maintainer="veka-server"
LABEL description="Downloader container for models with aria2"

# Installer les dépendances nécessaires
RUN apk add --no-cache wget git git-lfs aria2 coreutils

# Copier le script de téléchargement dans l'image
COPY download_models.sh /download_models.sh

# Rendre le script exécutable
RUN chmod +x /download_models.sh

# Point d'entrée
CMD ["sh", "/download_models.sh"]
