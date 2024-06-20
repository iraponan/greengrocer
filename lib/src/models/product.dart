class Product {
  Product({
    this.id,
    required this.productName,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

  String? id;
  String productName;
  String imgUrl;
  String unit;
  double price;
  String description;

  @override
  String toString() {
    return 'ProductModel{id: $id, productName: $productName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description}';
  }
}
