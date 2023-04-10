import 'dart:convert';

import 'package:http/http.dart' as http;

import '../exceptions/exception.dart';
import '../models/advice_model.dart';

abstract class AdviceRemoteDataSource {
  /// requests a random advice from the API
  /// returns [AdviceModel] if successfull
  /// throws a [ServerException] if status code is not 200
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final http.Client client;

  AdviceRemoteDataSourceImpl({required this.client});

  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);
      return AdviceModel.fromJson(responseBody);
    }
  }
}
