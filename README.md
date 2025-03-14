# Flutter Calculator

Une simple calculatrice développée avec Flutter.

## Fonctionnalités

- Opérations de base : addition, soustraction, multiplication, division
- Pourcentages
- Changement de signe (+/-)
- Point décimal
- Effacement (backspace)
- Historique des calculs

### Aperçu de l'application

Interface principale et addition simple :

![Addition simple](doc/images/Addition.png)

Addition en chaîne :

![Addition en chaîne](doc/images/Chain%20addition.png)

Calcul de pourcentage :

![Calcul de pourcentage](doc/images/Percentage.png)

Affichage du résultat :

![Affichage du résultat](doc/images/Result.png)

Historique des calculs :

![Historique des calculs](doc/images/History.png)

## Choix techniques et difficultés

### Double affichage
- Affichage supérieur : expression en cours
- Affichage inférieur : résultat en temps réel
- Difficulté : synchroniser les deux affichages

### Historique des calculs
- Difficulté : permettre la réutilisation des calculs précédents
- Solution : dialogue avec liste cliquable

### Gestion des erreurs
- Difficulté : prévenir les crashes (ex: division par zéro)
- Solution : vérifications et exceptions

### Programmation en Dart
- Difficulté : maîtrise du langage Dart et ses spécificités
- Solution : revoir les cours et la documentation
