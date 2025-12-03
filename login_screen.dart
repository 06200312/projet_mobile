import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:nexus_auth_flutter/core/auth_provider.dart';
import 'package:nexus_auth_flutter/ui/widgets/auth_text_field.dart';
import 'package:nexus_auth_flutter/ui/widgets/social_auth_button.dart';
import 'package:nexus_auth_flutter/ui/widgets/password_strength_indicator.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final showPassword = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Connexion'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Content de vous revoir !',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Connectez-vous pour continuer',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 40),
              AuthTextField(
                controller: emailController,
                label: 'Adresse Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre email';
                  }
                  if (!value.contains('@')) {
                    return 'Email invalide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AuthTextField(
                controller: passwordController,
                label: 'Mot de Passe',
                prefixIcon: Icons.lock_outline,
                obscureText: !showPassword.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () => showPassword.value = !showPassword.value,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              PasswordStrengthIndicator(password: passwordController.text),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Implement forgot password
                  },
                  child: const Text('Mot de passe oublié ?'),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final authProvider = context.read<AuthProvider>();
                      final success = await authProvider.signInWithEmail(
                        email: emailController.text.trim(),
                        password: passwordController.text,
                      );
                      
                      if (!success && authProvider.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(authProvider.errorMessage!),
                            backgroundColor: Theme.of(context).colorScheme.error,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text(
                    'Se Connecter',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Ou continuer avec',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialAuthButton(
                    icon: Icons.g_mobiledata,
                    color: Colors.red,
                    onPressed: () async {
                      final authProvider = context.read<AuthProvider>();
                      await authProvider.signInWithGoogle();
                    },
                  ),
                  const SizedBox(width: 16),
                  SocialAuthButton(
                    icon: Icons.facebook,
                    color: Colors.blue,
                    onPressed: () {
                      // TODO: Implement Facebook auth
                    },
                  ),
                  const SizedBox(width: 16),
                  SocialAuthButton(
                    icon: Icons.apple,
                    color: Colors.black,
                    onPressed: () {
                      // TODO: Implement Apple auth
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous n'avez pas de compte ? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text('Inscrivez-vous'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}