import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:procom_kas/chore/handler/service_result.dart';
import 'package:procom_kas/chore/instance/api_instance.dart';
import 'package:procom_kas/data/models/movie_model.dart';

class MovieService extends ApiInstance {
  Future<ServiceResult<List<MovieModel>>> fetchMovies() async {
    setHeaders(headers);
    final response =
        await http.get(Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> results = jsonResponse['results'];
      final List<MovieModel> data =
          results.map((json) => MovieModel.fromJson(json)).toList();

      return ServiceResult.success(data);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
