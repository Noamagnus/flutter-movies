class PaginatedResponse<T> {
  final List<T> items;
  final int page;
  final int totalPages;
  final int totalResults;

  PaginatedResponse({
    required this.items,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json, Function modelFromJson) {
    return PaginatedResponse(
      items: List<T>.from(json['results'].map((itemJson) => modelFromJson(itemJson))),
      page: json['page'] as int,
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
