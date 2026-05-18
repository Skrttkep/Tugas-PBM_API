import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = "https://task.itprojects.web.id/api";

  static Future<bool> login(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      String token = data["data"]["token"];

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("token", token);

      return true;
    }

    return false;
  }

  static Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";

    final response = await http.get(
      Uri.parse("$baseUrl/products"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print(response.body);

    final decoded = jsonDecode(response.body);

    dynamic data = decoded["data"];

    List products = [];

    if (data is List) {
      products = data;
    } else if (data is Map && data["data"] is List) {
      products = data["data"];
    } else if (data is Map && data["products"] is List) {
      products = data["products"];
    }

    return products
        .map(
          (item) => Product.fromJson(item),
        )
        .toList();
  }

  static Future<bool> addProduct(
    String name,
    int price,
    String description,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";

    final response = await http.post(
      Uri.parse("$baseUrl/products"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": name,
        "price": price,
        "description": description,
      }),
    );

    print(response.body);

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> deleteProduct(int id) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";

    final response = await http.delete(
      Uri.parse("$baseUrl/products/$id"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print(response.body);

    return response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204;
  }

  static Future<bool> submitProduct(
    String name,
    double price,
    String description,
    String githubUrl,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";

    final response = await http.post(
      Uri.parse("$baseUrl/products/submit"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": name,
        "price": price,
        "description": description,
        "github_url": githubUrl,
      }),
    );

    print(response.body);

    return response.statusCode == 200 || response.statusCode == 201;
  }
}