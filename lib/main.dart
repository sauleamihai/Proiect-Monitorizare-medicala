import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proiect_monitoorizare_pacienti/Sign_up.dart';
void main() {
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCEBE0),
        elevation: 0,
        title: Center(
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
                  SizedBox(height: 20),
                  Text(
                    "Bun venit pe aplicația MEDLIV",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email sau număr de telefon',
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.cyan[400],
                      ),
                      style: TextStyle(fontSize: 20),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Parola',
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.cyan[400],
                      ),
                      style: TextStyle(fontSize: 20),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality for sign-in button
                      },
                      child: Text(
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
          Text('Sign Up',style: TextStyle(fontSize: 15),),
          SizedBox(height: 10),
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