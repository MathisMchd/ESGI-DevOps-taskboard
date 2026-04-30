

## Quels stages votre pipeline doit-elle comporter ?

- **Build/Test** : Compilation, tests unitaires/intégration, linting.
- **Deploy** : Construction et déploiement de l'image Docker.

## Quels jobs dans chaque stage ?

- **Build/Test** :
  - Lint : Vérification du code avec ESLint.
  - Test : Exécution des tests avec Jest et couverture.
- **Deploy** :
  - Build Image : Construction de l'image Docker multi-stage.
  - Push Image : Push vers GitHub Container Registry.
  - Deploy : Déploiement avec Docker Compose (uniquement sur main).

## Quelles dépendances entre jobs (`needs`) ?

- Test dépend de Lint.
- Build Image dépend de Test.
- Push Image dépend de Build Image.
- Deploy dépend de Push Image.

## Sur quels événements la pipeline se déclenche-t-elle ?

- Push sur la branche `main`.
- Pull requests vers `main`.

## Certains jobs doivent-ils s'exécuter uniquement sur `main` ?

Oui, le job Deploy s'exécute uniquement sur la branche `main` après validation des tests et build.