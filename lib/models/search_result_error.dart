class SearchResultError {
  final String message;
  final String details;

  const SearchResultError({this.message, this.details});

  static SearchResultError fromJson(dynamic json) {
    return SearchResultError(
      message: json['message'] as String,
      details: json['errors'].toString()
    );
  }
}