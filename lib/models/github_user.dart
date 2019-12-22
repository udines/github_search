class GithubUser {
  const GithubUser({this.login, this.avatarUrl});

  final String login;
  final String avatarUrl;

  static GithubUser fromJson(dynamic json) {
    return GithubUser(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String
    );
  }
}