class SearchModel {
  final String? id;
  final String? token;
  final String? query;

  SearchModel({
    required this.id,
    required this.token,
    required this.query,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "token": token,
      "query": query ?? 'a',
    };
  }
}
