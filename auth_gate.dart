import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexus_auth_flutter/core/auth_provider.dart';
import 'package:nexus_auth_flutter/ui/screens/welcome_screen.dart';
import 'package:nexus_auth_flutter/ui/screens/dashboard_screen.dart';
import 'package:nexus_auth_flutter/ui/screens/loading_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    
    if (authProvider.isLoading) {
      return const LoadingScreen();
    }
    
    if (authProvider.user != null) {
      return DashboardScreen(username: authProvider.user!.displayName ?? 'Utilisateur');
    }
    
    return const WelcomeScreen();
  }
}