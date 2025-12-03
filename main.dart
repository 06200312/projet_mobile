import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexus_auth_flutter/core/auth_provider.dart';
import 'package:nexus_auth_flutter/ui/screens/auth_gate.dart';
import 'package:nexus_auth_flutter/ui/theme/app_theme.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configuration initiale
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const NexusAuthApp(),
    ),
  );
}

class NexusAuthApp extends StatelessWidget {
  const NexusAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Auth',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AuthGate(),
    );
  }
}