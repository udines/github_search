class SearchResultError {
  const SearchResultError({this.message, this.details});

  final String message;
  final String details;

  static SearchResultError fromJson(dynamic json) {
    return SearchResultError(
      message: json['message'] as String,
      details: json['errors'].toString()
    );
  }
}