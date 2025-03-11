import 'package:dio/dio.dart';

class Cities {
  final Dio _dio = Dio();

  Future<List<String>> getCities() async {
    try {
      final response = await _dio.get('https://67b5afbb07ba6e59083dfde3.mockapi.io/school/City');
      return List<String>.from(response.data.map((city) => city['name'])).toSet().toList();
    } catch (e) {
      print('Error fetching cities: $e');
      return [];
    }
  }
}