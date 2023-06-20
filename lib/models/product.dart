class Product {
  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  //List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    //required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      discountPercentage: json['discountPercentage'] as double,
      rating: json['rating'] as double,
      stock: json['stock'] as int,
      brand: json['brand'] as String,
      category: json['brand'] as String,
      thumbnail: json['thumbnail'] as String,
      //images: json['images'] as List<String>,
    );
  }
}
