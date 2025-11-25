// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postman_practice/screens/home_screen.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final locationCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email'), keyboardType: TextInputType.emailAddress),
            TextField(controller: passCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            TextField(controller: contactCtrl, decoration: InputDecoration(labelText: 'Contact'), keyboardType: TextInputType.phone),
            TextField(controller: locationCtrl, decoration: InputDecoration(labelText: 'Location')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await ApiService.register(
                  name: nameCtrl.text,
                  email: emailCtrl.text,
                  password: passCtrl.text,
                  contact: contactCtrl.text,
                  location: locationCtrl.text,
                );
                if (result['success'] == true) {
                  Get.offAll(() => LoginScreen());
                  Get.snackbar('Success', 'Registered! Now Login', backgroundColor: Colors.green, colorText: Colors.white);
                } else {
                  Get.snackbar('Failed', result['message'] ?? 'Error', backgroundColor: Colors.red, colorText: Colors.white);
                }
              },
              child: Text('Register'),
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                },
                child: Text("data"))
          ],
        ),
      ),
    );
  }
}