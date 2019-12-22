import 'package:githubsearch/models/github_user.dart';

class SearchResultItem {
  const SearchResultItem({this.fullName, this.htmlUrl, this.owner});
  
  final String fullName;
  final String htmlUrl;
  final GithubUser owner;

  static SearchResultItem fromJson(dynamic json) {
    return SearchResultItem(
      fullName: json['full_name'] as String,
      htmlUrl: json['html_url'] as String,
      owner: GithubUser.fromJson(json['owner'])
    );
  }
}