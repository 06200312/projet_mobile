import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:nexus_auth_flutter/core/auth_provider.dart';
import 'package:nexus_auth_flutter/ui/widgets/auth_text_field.dart';
import 'package:nexus_auth_flutter/ui/widgets/password_strength_indicator.dart';

class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final showPassword = useState(false);
    final showConfirmPassword = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final acceptTerms = useState(false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Inscription'),
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
                'Rejoignez-nous !',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Créez votre compte en quelques étapes',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 40),
              AuthTextField(
                controller: usernameController,
                label: 'Nom d\'utilisateur',
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir un nom d\'utilisateur';
                  }
                  if (value.length < 3) {
                    return 'Minimum 3 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
                    return 'Veuillez saisir un mot de passe';
                  }
                  if (value.length < 8) {
                    return 'Minimum 8 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              PasswordStrengthIndicator(password: passwordController.text),
              const SizedBox(height: 20),
              AuthTextField(
                controller: confirmPasswordController,
                label: 'Confirmer le Mot de Passe',
                prefixIcon: Icons.lock_outline,
                obscureText: !showConfirmPassword.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    showConfirmPassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () => showConfirmPassword.value = !showConfirmPassword.value,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez confirmer votre mot de passe';
                  }
                  if (value != passwordController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: acceptTerms.value,
                    onChanged: (value) => acceptTerms.value = value ?? false,
                  ),
                  Expanded(
                    child: Wrap(
                      children: [
                        const Text('J\'accepte les '),
                        GestureDetector(
                          onTap: () {
                            // TODO: Show terms
                          },
                          child: Text(
                            'conditions d\'utilisation',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(' et la '),
                        GestureDetector(
                          onTap: () {
                            // TODO: Show privacy policy
                          },
                          child: Text(
                            'politique de confidentialité',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: acceptTerms.value
                      ? () async {
                          if (formKey.currentState!.validate()) {
                            final authProvider = context.read<AuthProvider>();
                            final success = await authProvider.signUpWithEmail(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                              username: usernameController.text.trim(),
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
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text(
                    'Créer mon Compte',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Vous avez déjà un compte ? '),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Connectez-vous'),
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