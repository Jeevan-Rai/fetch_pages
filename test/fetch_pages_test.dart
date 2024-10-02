import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:your_package/fetch_pages.dart'; // Import your package

class MockClient extends Mock implements http.Client {}

void main() {
  group('FetchPages', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('fetches and stores pages when versionConfig.json is outdated', () async {
      SharedPreferences.setMockInitialValues({}); // Mock SharedPreferences
      final prefs = await SharedPreferences.getInstance();

      // Mocking the server version config response
      when(mockClient.get(Uri.parse('https://106.51.72.98:3004/version-config/MyBT')))
          .thenAnswer((_) async => http.Response('{"version": 2}', 200));

      // Mocking pages response
      when(mockClient.get(Uri.parse('https://106.51.72.98:3004/version-config/MyBT')))
          .thenAnswer((_) async => http.Response('{"pageName": "testPage"}', 200));

      await FetchPages.fetchPagesFromAPI('https://106.51.72.98:3004/version-config/MyBT');
      
      // Verify SharedPreferences is updated
      expect(prefs.getString('responseBodyFromAPI'), '{"pageName": "testPage"}');
    });
  });
}
