import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Sign_up.dart';
import 'firebase_options.dart'; // Ensure this is properly set up
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buna ziua vă aflați pe pagina de log_in',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCCEBE0),
        elevation: 0,
        title: const Center(
          child: Text(
            "Autentificare",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.blueGrey,
              fontFamily: 'Futura',
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'images/fundal.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/medic.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Bun venit pe aplicația MEDLIV",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email sau număr de telefon',
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.cyanAccent,
                      ),
                      style: const TextStyle(fontSize: 20),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Parola',
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.cyanAccent,
                      ),
                      style: const TextStyle(fontSize: 20),
                      maxLines: 1,
                      minLines: 1,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          // If sign-in successful, navigate to the next screen
                          // Replace 'NextScreen()' with the screen you want to navigate to
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                            // Display feedback to the user
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No user found for that email.')),
                            );
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                            // Display feedback to the user
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Wrong password provided for that user.')),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Sign Up', style: TextStyle(fontSize: 15)),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            tooltip: 'Sign Up',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignupPage();
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the next screen!'),
      ),
    );
  }
}
