import 'package:advicer/data/datasources/advice_remote_datasource.dart';
import 'package:advicer/data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDataSource', () {
    group('should return AdviceModel', () {
      test('when Client response was 200 and has valid data', () async {
        final mockClient = MockClient();
        final adviceRemoteDataSourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);

        const responseBody = '{"advice": "test advice", "advice_id": 1}';

        when(mockClient
            .get(Uri.parse('https://api.flutter-community.com/api/v1/advice/'),
                headers: {'Content-Type': 'application/json'})).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)));

        final result =
            await adviceRemoteDataSourceUnderTest.getRandomAdviceFromApi();
        expect(result, AdviceModel(advice: 'test advice', id: 1));
      });
    });
  });
}
