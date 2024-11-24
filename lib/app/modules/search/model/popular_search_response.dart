import 'dart:convert';

PopularSearchResponse popsearchResponseFromJson(String str) =>
    PopularSearchResponse.fromJson(json.decode(str));

String popsearchResponseToJson(PopularSearchResponse data) =>
    json.encode(data.toJson());

class PopularSearchResponse {
  final int success;
  final String message;
  final List<String> popularSearch;

  PopularSearchResponse({
    required this.success,
    required this.message,
    required this.popularSearch,
  });

  // Factory constructor to create an instance from JSON
  factory PopularSearchResponse.fromJson(Map<String, dynamic> json) {
    return PopularSearchResponse(
      success: json['success'] as int,
      message: json['message'] as String,
      popularSearch: List<String>.from(json['popular_search'] as List<dynamic>),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'popular_search': popularSearch,
    };
  }
}
