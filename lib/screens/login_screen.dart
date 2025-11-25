// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passCtrl,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (emailCtrl.text.isEmpty || passCtrl.text.isEmpty) {
                  Get.snackbar('Error', 'Fill all fields');
                  return;
                }

                try {
                  final result = await ApiService.login(emailCtrl.text, passCtrl.text);
                  if (result['success'] == true) {
                    Get.offAll(() => HomeScreen());
                    Get.snackbar('Success', result['message'], backgroundColor: Colors.green, colorText: Colors.white);
                  } else {
                    Get.snackbar('Failed', result['message'] ?? 'Login Failed', backgroundColor: Colors.red, colorText: Colors.white);
                  }
                } catch (e) {
                  Get.snackbar('Error', 'Network Error');
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => Get.to(() => RegisterScreen()),
              child: Text('Create New Account'),
            ),
          ],
        ),
      ),
    );
  }
}