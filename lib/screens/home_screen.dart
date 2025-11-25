// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final codeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(title: Text('Home')),
  body: Padding(
  padding: EdgeInsets.all(20),
  child: Column(
  children: [
  Text('Verify Your Email', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
  TextField(controller: codeCtrl, decoration: InputDecoration(labelText: 'OTP Code'), keyboardType: TextInputType.number),
  SizedBox(height: 20),
  ElevatedButton(
  onPressed: () async {
  final result = await ApiService.verifyEmail(emailCtrl.text, int.parse(codeCtrl.text));
  if (result['success'] == true) {
  Get.snackbar('Success', result['message'], backgroundColor: Colors.green, colorText: Colors.white);
  } else {
  Get.snackbar('Failed', result['message'] ?? 'Error', backgroundColor: Colors.red, colorText: Colors.white);
  }
  },
  child: Text('Verify Your Email'),
  ),
  ],
  ),
  ),
  );
  }
}