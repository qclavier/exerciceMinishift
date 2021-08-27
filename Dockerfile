# ----- Spécification de l'image de base -----
# obligatoire de précisé l'image avec la commande 'FROM <nom_image>:<tag>'
# si <tag> n'est pas précisé ce sera 'latest' par défaut
FROM debian 

# Ceci est un commentaire

# --- Pour ajouter des métadonnées
LABEL version="1.0" maintainer="quentin clavier"

#--- Pour se déplacer à l'intérieur de l'image
WORKDIR /app
# Si le dossier /app n'existe pas, il est créée puis déplacer à l'intérieur
# Tout les instructions/commandes suivantes se dérouleront dans le dossier /app

#--- Pour copier des éléments à l'intérieur de l'image
# La source est locale
# Chemin absolu
COPY test.txt /app/
# OU
# Chemin relatif
#COPY test.txt . 

# La source peut être un URL (source distante)
#ADD <chemin_source/fichier.extension> <chemin_de_destination (absolu ou relatif)>


#--- Pour déclarer une variable locale au dockerfile 
ARG APT_FLAG="-y"
#--- Pour déclarer une variable d'environnement (accessible par les container créé à partir du dockerfile)
ENV TOTO="tata"

#--- Pour exécuter des commandes à l'intérieur de l'image
# 2 commandes sur une ligne :
RUN apt-get update && apt-get upgrade ${APT_FLAG}
# Utilisation de la variable locale APT_FLAG
# 1 commande sur une ligne :
RUN apt-get install sqlite3 -y
# -y permet de forcer la confirmation de l'installation de sqlite3 

#--- Pour exposer un ou plusieurs ports
EXPOSE 5000

#--- Pour indiquer l'utilisation de l'image lors de la création du conteneur
# 1 seule action ENTRYPOINT/CMD possible par dockerfile
#ENTRYPOINT fige l'utilisation de 'bash' : surchage de commande à l'initialisation impossible
# surcharge de commande = exécution par un utilisateur via "docker exec -it..."
#ENTRYPOINT ["bash"]
# Exemple avec plusieurs commandes qui peuvent avoir plus de sens que juste du bash :
#ENTRYPOINT ["python", "fichier.py", "sqlite3", "bdd.db"]
# 'bash' est l'utilisation par défaut mais permet une autre : surchage de commande à l'initialisation possible)
CMD ["bash"]
# Exemple avec du python
#CMD ["python", "fichier.py"]
# le conteneur sera créé en langage python et le fichier.py sera exécuter

