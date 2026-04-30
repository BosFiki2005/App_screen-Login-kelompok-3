class CartItem {
  final String name;
  final int price;
  final int count;
  final int totalPrice;

  CartItem({
    required this.name,
    required this.price,
    required this.count,
    required this.totalPrice,
  });

  // Konversi JSON ke Object Dart
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      count: json['count'] ?? 0,
      totalPrice: json['total_price'] ?? 0,
    );
  }
}