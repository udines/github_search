import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:githubsearch/models/search_result.dart';
import 'package:githubsearch/models/search_result_error.dart';
import 'package:http/http.dart' as http;

class GithubClient {
  GithubClient({
    http.Client httpClient,
    this.baseUrl = 'https://api.github.com/search/repositories?q='
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<SearchResult> search(String term) async {
    log('get: $baseUrl$term');
    final http.Response response = await httpClient.get(Uri.parse('$baseUrl$term'));
    final Map<String, dynamic> results = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return SearchResult.fromJson(results);
    } else {
      throw SearchResultError.fromJson(results);
    }
  }
}