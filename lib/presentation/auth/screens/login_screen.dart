import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:notes_app/presentation/auth/bloc/auth_event.dart';
import 'package:notes_app/presentation/auth/bloc/auth_state.dart';
import 'package:notes_app/presentation/auth/screens/sign_up_screen.dart';
import 'package:notes_app/presentation/notes/screens/notes_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const NotesScreen()));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => context.read<AuthBloc>().add(
                              LoginEvent(emailController.text,
                                  passwordController.text),
                            ),
                        child: const Text('Login'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SignUpScreen()));
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
