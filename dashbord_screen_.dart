import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexus_auth_flutter/core/auth_provider.dart';
import 'package:nexus_auth_flutter/ui/widgets/profile_card.dart';
import 'package:nexus_auth_flutter/ui/widgets/feature_card.dart';

class DashboardScreen extends StatelessWidget {
  final String username;
  
  const DashboardScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de Bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Settings screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(
              username: username,
              email: 'user@example.com',
              onLogout: () {
                context.read<AuthProvider>().signOut();
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'Fonctionnalités',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: const [
                FeatureCard(
                  icon: Icons.security,
                  title: 'Sécurité',
                  description: 'Gérer votre sécurité',
                ),
                FeatureCard(
                  icon: Icons.history,
                  title: 'Historique',
                  description: 'Voir votre activité',
                ),
                FeatureCard(
                  icon: Icons.devices,
                  title: 'Appareils',
                  description: 'Appareils connectés',
                ),
                FeatureCard(
                  icon: Icons.help_center,
                  title: 'Aide',
                  description: 'Centre d\'aide',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Compte Vérifié',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            'Votre compte est sécurisé et vérifié',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}