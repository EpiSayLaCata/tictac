# Tic Tac Toe – Flutter Clean Architecture

## 🎯 Objectif

Ce projet est un **Tic Tac Toe** développé en **Flutter**.

L’objectif principal n’est pas la complexité fonctionnelle du jeu, mais la démonstration de :

* bonnes pratiques d’architecture (Clean Architecture)
* séparation claire des responsabilités
* maîtrise de Flutter moderne (Material 3, Riverpod 3, go_router)
* qualité du code et de l’UX

---

## 🧱 Architecture

Le projet suit une **Clean Architecture simplifiée**, organisée autour de **features**.

```
lib/
├── core/
│   ├── assets/        # Constantes d’assets (Rive)
│   ├── providers/     # Providers globaux (Providers, thème)
│   ├── router/        # Configuration go_router
│   └── theme/         # Thème Material 3 (light / dark)
│
├── features/
│   └── game/
│       ├── data/      # Implémentations concrètes (datasource, repository)
│       ├── domain/    # Logique métier pure (entities, usecases, repositories, services)
│       └── presentation/
│           ├── controllers/  # State management (Riverpod)
│           ├── pages/        # Écrans
│           └── widgets/      # Widgets UI réutilisables
│
├── app.dart
└── main.dart
```

### Principes respectés

* Le **domain** ne dépend de rien (pas de Flutter, pas de Riverpod)
* La **presentation** ne connaît pas la couche data
* Les dépendances sont assemblées dans un **composition root** (`core/providers`)

---

## 🧠 State Management

Le state management est assuré avec **Riverpod 3**.

* `GameController` orchestre l’état du jeu
* L’UI observe uniquement le `GameState`
* Les actions passent par des **use cases** (PlayMove, ResetGame…)

Cela permet :

* une logique métier testable
* une UI simple et déclarative
* un découplage fort entre logique et rendu

---

## 🎨 UI & Thème

### Material 3

* Utilisation complète de **Material 3**
* `ColorScheme.fromSeed` pour une palette cohérente
* Thème clair / sombre personnalisés

Le thème est centralisé dans :

```
core/theme/app_theme.dart
```

### Composants UI

* `BoardCell` stylé via le `ColorScheme`
* Animations légères (`AnimatedSwitcher`, `AnimatedScale`)
* Highlight de la ligne gagnante

---

## 🎬 Animations (Rive)

Une animation **Rive** est affichée en overlay à la fin de la partie.

* Intégration via l’API officielle `RiveWidget`
* Chargement manuel du `.riv` (controller dédié)
* Déclenchée uniquement depuis la couche **presentation**

➡️ Le domain reste totalement ignorant de Rive.

---

## 🧭 Navigation

La navigation est gérée avec **go_router** :

* Configuration centralisée dans `core/router`
* Architecture prête à accueillir d’autres écrans/features

---

## ✨ Choix assumés

* Utilisation de l'IA pour plusieurs tâches dans le code 

---


Merci pour votre lecture.
