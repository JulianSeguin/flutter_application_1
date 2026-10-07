import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
final formKey = GlobalKey<FormState>();
String email = '';
String password = '';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/X.webp', height: 30),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Entrez vos identifiants',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez votre adresse email';
                  }
                  return null;
                },
                onSaved: (value) => email = value ?? '',
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: _isPasswordVisible,
              validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Entrez votre mot de passe';
          }
          if (value.length < 12) {
            return 'Entrez un mot de passe plus long (12 caractères minimum)';
          }
          return null;
        },
        onSaved: (value) => password = value ?? '',
          decoration: InputDecoration(
            labelText: 'Password',
              border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                    // add logic to toggle password visibility
                    },
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              debugPrint('Email: $email, Password: $password');
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
              // Code d'authentification
              // ...
                }
              },
              style : ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 20),
              ),
                child: Text('Connexion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}