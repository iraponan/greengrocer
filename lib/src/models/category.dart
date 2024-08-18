import 'package:greengrocer/src/helpers/data_table_keys/columns/categories.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Category {
  String id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  Category.fromParse(ParseObject parseObject)
      : id = parseObject.objectId ?? '',
        name = parseObject.get(CategoryColumnKeys.name) ?? '';

  @override
  String toString() {
    return 'Category{id: $id, name: $name}';
  }
}
