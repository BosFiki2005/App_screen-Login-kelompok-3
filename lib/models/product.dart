class Product {
  final String name;
  final String price;
  final String imageUrl;
  final double star;

  Product({
    required this.name, 
    required this.price, 
    required this.imageUrl, 
    required this.star
  });

  // Fungsi untuk mengonversi JSON ke Object Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      // Price di JSON adalah int, kita konversi ke String atau format Rupiah
      price: "Rp ${json['price']}", 
      imageUrl: json['image'],
      star: (json['star'] as num).toDouble(),
    );
  }
}