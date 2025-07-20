# Utilise une image Java légère
FROM openjdk:17-jdk-slim

# Crée un dossier pour l'app
WORKDIR /app

# Copie le fichier JAR dans l'image
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# Expose le port configuré dans application.properties
EXPOSE 8081

# Commande de lancement de l'app
ENTRYPOINT ["java", "-jar", "app.jar"]
