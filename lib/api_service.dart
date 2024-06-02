import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiService {
  final Dio dio = Dio();
  final GetStorage myStorage = GetStorage();
  final String apiUrl = 'https://mobileapis.manpits.xyz/api';

  Future<Response?> request({
    required String endpoint,
    required String method,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.request(
        '$apiUrl/$endpoint',
        options: Options(
          method: method,
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
      return null;
    }
  }
}
