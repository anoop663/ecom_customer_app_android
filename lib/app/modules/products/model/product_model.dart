class ProductRequest {
  final String id;
  final String token;
  final int isVariant;
  final int parentId;
  final List<int> optionIds;

  ProductRequest({
    required this.id,
    required this.token,
    required this.isVariant,
    required this.parentId,
    required this.optionIds,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "token": token,
      "is_variant": isVariant,
      "parent_id": parentId,
      "option_ids": optionIds,
    };
  }
}
