import 'package:githubsearch/models/search_result.dart';
import 'package:githubsearch/services/github_cache.dart';
import 'package:githubsearch/services/github_client.dart';

class GithubRepository {
  GithubRepository(this.client, this.cache);

  final GithubClient client;
  final GithubCache cache;

  Future<SearchResult> search(String term) async {
    if (cache.contains(term)) {
      return cache.get(term);
    } else {
      final SearchResult result = await client.search(term);
      cache.set(term, result);
      return result;
    }
  }
}