import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCreatingAccount == true ? 'Zarejestruj się' : 'Zaloguj się',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: widget.emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(200, 218, 216, 216)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.passwordController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Hasło',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(200, 218, 216, 216)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Text(errorMessage),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (isCreatingAccount == true) {
                    // rejestracja
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  } else {
                    // logowanie
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  }
                },
                child: Text(isCreatingAccount == true
                    ? 'Zarejestruj się'
                    : 'Zaloguj się'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
              ),
              const SizedBox(height: 20),
              if (isCreatingAccount == false) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: Text(
                    'Utwórz konto',
                    style: GoogleFonts.lato(
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
              if (isCreatingAccount == true) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  },
                  child: Text(
                    'Masz już konto?',
                    style: GoogleFonts.lato(
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
