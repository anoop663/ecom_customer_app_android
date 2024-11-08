class HomeAuth2 {
  final String? id;
  final String? token;
  final String? slug;
  final String? quantity;
  final String? store;
  HomeAuth2( {
    this.id,
    this.token,
    this.slug,
    this.quantity, 
    this.store, 
    
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'quantity':quantity,
      'slug':slug,
      'store':store,
    };
  }
}
