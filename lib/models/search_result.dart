import 'package:githubsearch/models/search_result_item.dart';

class SearchResult {
  const SearchResult({this.items});

  final List<SearchResultItem> items;

  static SearchResult fromJson(Map<String, dynamic> json) {
    final List<SearchResultItem> items = (json['items'] as List<dynamic>)
      .map((dynamic item) => SearchResultItem.fromJson(item as Map<String, dynamic>))
      .toList();
    return SearchResult(items: items);
  }
}