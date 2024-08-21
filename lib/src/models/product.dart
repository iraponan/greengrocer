import 'package:greengrocer/src/helpers/data_table_keys/columns/products.dart';
import 'package:greengrocer/src/models/category.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Product {
  String id;
  String productName;
  String imgUrl;
  String unit;
  double price;
  String description;
  Category category;

  Product(
      {this.id = '',
      required this.productName,
      required this.imgUrl,
      required this.unit,
      required this.price,
      required this.description,
      required this.category});

  Product.fromParse(ParseObject object)
      : id = object.objectId ?? '',
        productName = object.get<String>(ProductsColumnKeys.name) ?? '',
        imgUrl = (object.get<ParseFileBase>(ProductsColumnKeys.picture)
                    as ParseFileBase)
                .url ??
            '',
        unit = object.get<String>(ProductsColumnKeys.unit) ?? '',
        price = double.tryParse(
                object.get<num>(ProductsColumnKeys.price).toString()) ??
            0,
        description = object.get<String>(ProductsColumnKeys.description) ?? '',
        category = Category.fromParse(object.get(ProductsColumnKeys.category));

  @override
  String toString() {
    return 'ProductModel{id: $id, productName: $productName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description}';
  }
}
