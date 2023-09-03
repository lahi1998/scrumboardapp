import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scrumboard/http_service.dart';

class LogonProvider extends ChangeNotifier {
  Future<String> login(String username, String password) async {
    final url = Uri.parse('https://10.0.2.2:7168/api/Auth/login');
    
    HttpClientService httpClientService = HttpClientService();
    await httpClientService.initialiseHttpClient();
    HttpClient client = httpClientService.httpClient;

    try {
      var request = await client.postUrl(url);

      request.headers.add('Content-Type', 'application/json');

      var payload = {
        'username': username,
        'password': password,
      };
      request.write(jsonEncode(payload));

      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        final data = json.decode(responseBody);
        final token = data['token'];
        print("Logged in");
        return token;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to connect: $e');
    } finally {
      client.close();
    }
  }
}
