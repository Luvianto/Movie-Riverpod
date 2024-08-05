import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:procom_kas/chore/handler/api_response.dart';

class ApiInstance {
  String baseUrl = dotenv.env['MOVIE_BASE_URL']!;
  String apiKey = dotenv.env['MOVIE_API_KEY']!;
  Map<String, String> headers = {};

  void setBaseUrl(String url) {
    baseUrl = url;
  }

  void setHeaders(Map<String, String> headers) {
    this.headers = headers;
  }

  Future<ApiResponse> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );
    return _handleResponse(response);
  }

  Future<ApiResponse> post<T>(String endpoint, T body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<ApiResponse> put<T>(String endpoint, T body) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<ApiResponse> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );
    return _handleResponse(response);
  }

  ApiResponse _handleResponse(http.Response rawResponse) {
    try {
      final decodedResponse = json.decode(rawResponse.body);
      final response = ApiResponse.fromJson(decodedResponse);
      if (response.status) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'An error occurred',
      );
    }
  }
}
