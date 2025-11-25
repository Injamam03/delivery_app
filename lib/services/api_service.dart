// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // তোমার ব্যাকএন্ড URL
  static const String baseUrl = 'https://moshfiqur5000.binarybards.online/api';

  // Token সেভ করা
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Token পাওয়া
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Register
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String contact,
    required String location,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "name": name,
        "role": "USER",
        "contact": contact,
        "countryCode": "+880",
        "email": email,
        "password": password,
        "location": location,
      }),
    );

    return json.decode(response.body);
  }

  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );

    final data = json.decode(response.body);
    if (data['success'] == true) {
      await saveToken(data['data']); // JWT Token সেভ
    }
    return data;
  }

  // Email Verify
  static Future<Map<String, dynamic>> verifyEmail(String email, int oneTimeCode) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-email'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "email": email,
        "oneTimeCode": oneTimeCode,
      }),
    );

    return json.decode(response.body);
  }
}