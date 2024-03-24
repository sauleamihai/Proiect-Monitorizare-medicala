import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import the intl package
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                await _selectDate();
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: dateOfBirthController,
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                  keyboardType: TextInputType.datetime,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedRole,
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'patient',
                  child: Text('Patient'),
                ),
                DropdownMenuItem(
                  value: 'doctor',
                  child: Text('Doctor'),
                ),
              ],
              decoration: InputDecoration(labelText: 'Role'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await registerUserWithEmailAndPassword(context);
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUserWithEmailAndPassword(BuildContext context) async {
    try {
      // Check if passwords match
      if (passwordController.text != confirmPasswordController.text) {
        throw 'Passwords do not match';
      }

      // Register user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If user registration is successful, save user data to Firestore
      await saveUserDataToFirestore(userCredential.user!.uid); // Pass UID of the registered user

      // Clear text fields
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      dateOfBirthController.clear();
      phoneNumberController.clear();
      addressController.clear();

      // Navigate back to login page
      Navigator.pop(context); // Pop current route (SignupPage) and go back to the previous page
    } catch (error) {
      // Show error message as a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error registering user: $error');
    }
  }

  Future<void> saveUserDataToFirestore(String userId) async {
    try {
      final firestore = FirebaseFirestore.instance;

      await firestore.collection('users').doc(userId).set({
        'Nume': firstNameController.text,
        'Prenume': lastNameController.text,
        'Date of Birth': dateOfBirthController.text,
        'Email': emailController.text,
        'Phone Number': phoneNumberController.text,
        'Address': addressController.text,
        'Role': selectedRole, // Save selected role to Firestore
      });

      print('User data saved successfully');
    } catch (error) {
      print('Error saving user data: $error');
    }
  }
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        // Format the picked date to display only the date part
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        dateOfBirthController.text = formattedDate; // Update text field with selected date
      });
    }
  }
}
