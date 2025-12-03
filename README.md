# Nexus Auth - Application d'Authentification Moderne

Une application Flutter moderne d'authentification avec Firebase, proposant une interface unique et des fonctionnalités avancées.

## 🚀 Fonctionnalités

### 🔐 Authentification
- **Connexion Email/Mot de passe** avec validation en temps réel
- **Inscription sécurisée** avec indicateur de force de mot de passe
- **Connexion Google** intégrée
- **Gestion des sessions** avec Firebase Auth
- **Validation des formulaires** avancée

### 🎨 Interface Unique
- **Design moderne** avec Material 3
- **Thèmes clair/sombre** adaptatifs
- **Animations fluides** et micro-interactions
- **Indicateur de force de mot de passe** visuel
- **Gradients dynamiques** et transitions

### 📱 Architecture
- **State Management** avec Provider
- **Architecture modulaire** et scalable
- **Widgets réutilisables** personnalisés
- **Gestion d'erreurs** complète
- **Tests unitaires** prêts à être implémentés

## 🛠️ Technologies Utilisées

- **Flutter 3.19+** avec Dart 3.3+
- **Firebase Authentication** pour la sécurité
- **Google Sign-In** pour l'authentification sociale
- **Provider** pour la gestion d'état
- **Flutter Hooks** pour une meilleure gestion du cycle de vie
- **Packages UI** : lottie, shimmer, animated_text_kit

## 📁 Structure du Projet
nexus_auth_flutter/
├── lib/
│ ├── core/
│ │ └── auth_provider.dart # Gestionnaire d'authentification
│ ├── ui/
│ │ ├── screens/
│ │ │ ├── auth_gate.dart # Portail d'authentification
│ │ │ ├── welcome_screen.dart # Écran d'accueil
│ │ │ ├── login_screen.dart # Connexion
│ │ │ ├── register_screen.dart# Inscription
│ │ │ ├── dashboard_screen.dart # Tableau de bord
│ │ │ └── loading_screen.dart # Écran de chargement
│ │ ├── widgets/
│ │ │ ├── auth_text_field.dart# Champ texte personnalisé
│ │ │ ├── gradient_button.dart # Bouton avec gradient
│ │ │ ├── social_auth_button.dart # Boutons réseaux sociaux
│ │ │ ├── password_strength_indicator.dart # Indicateur mot de passe
│ │ │ ├── profile_card.dart # Carte profil
│ │ │ └── feature_card.dart # Carte fonctionnalité
│ │ └── theme/
│ │ └── app_theme.dart # Configuration des thèmes
│ └── main.dart # Point d'entrée
├── assets/
│ ├── animations/ # Animations Lottie
│ ├── images/ # Images statiques
│ └── icons/ # Icônes SVG
└── test/ # Tests unitaires

text

## ⚙️ Configuration

### 1. Prérequis
- Flutter SDK 3.19.0+
- Dart 3.3.0+
- Firebase Console compte
- Android Studio / VS Code

### 2. Configuration Firebase
1. Créer un projet sur [Firebase Console](https://console.firebase.google.com)
2. Activer Authentication → Méthodes de connexion :
   - Email/Mot de passe
   - Google
3. Télécharger les fichiers de configuration :
   - `google-services.json` pour Android
   - `GoogleService-Info.plist` pour iOS
4. Placer les fichiers dans les dossiers appropriés

### 3. Installation
```bash
# Cloner le projet
git clone <repository-url>

# Accéder au dossier
cd nexus_auth_flutter

# Installer les dépendances
flutter pub get

# Configurer Firebase
# Suivre les étapes Firebase ci-dessus

# Lancer l'application
flutter run
