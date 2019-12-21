import 'package:githubsearch/models/search_result.dart';
import 'package:githubsearch/services/github_cache.dart';
import 'package:githubsearch/services/github_client.dart';

class GithubRepository {
  final GithubClient client;
  final GithubCache cache;

  GithubRepository(this.client, this.cache);

  Future<SearchResult> search(String term) async {
    if (cache.contains(term)) {
      return cache.get(term);
    } else {
      final result = await client.search(term);
      cache.set(term, result);
      return result;
    }
  }
}