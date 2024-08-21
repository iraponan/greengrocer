import 'package:greengrocer/src/helpers/data_table_keys/columns/categories.dart';
import 'package:greengrocer/src/helpers/data_table_keys/columns/products.dart';
import 'package:greengrocer/src/helpers/data_table_keys/tables.dart';
import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/category.dart';
import 'package:greengrocer/src/models/product.dart';
import 'package:greengrocer/src/results/home.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class HomeRepository {
  Future<HomeResult<Category>> getAllCategories() async {
    final queryBuilder = QueryBuilder(
      ParseObject(TablesNameKeys.keyCategoriesTable),
    )..orderByAscending(CategoryColumnKeys.name);
    final response = await queryBuilder.query();

    if (response.success) {
      List<Category> categories =
          response.results!.map((c) => Category.fromParse(c)).toList();
      return HomeResult<Category>.success(categories);
    } else {
      return HomeResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }

  Future<HomeResult<Product>> getAllProducts({
    required int page,
    String searchName = '',
    Category? category,
    required int itemsPerPage,
  }) async {
    final queryBuilder =
        QueryBuilder(ParseObject(TablesNameKeys.keyProductsTable))
          ..includeObject([ProductsColumnKeys.category])
          ..setAmountToSkip(page * itemsPerPage)
          ..setLimit(itemsPerPage)
          ..orderByAscending(ProductsColumnKeys.name);

    if (category != null && category.id != 'Todos') {
      queryBuilder.whereEqualTo(
          ProductsColumnKeys.category,
          (ParseObject(TablesNameKeys.keyCategoriesTable)
                ..set(CategoryColumnKeys.id, category.id))
              .toPointer());
    }

    if (searchName.trim().isNotEmpty) {
      queryBuilder.whereContains(
        ProductsColumnKeys.name,
        searchName,
        caseSensitive: false,
      );
    }

    final response = await queryBuilder.query();

    if (response.success) {
      List<Product> products =
          response.results?.map((p) => Product.fromParse(p)).toList() ?? [];
      return HomeResult<Product>.success(products);
    } else {
      return HomeResult.error(
        ParseErrors.getDescription(response.error?.code ?? -1),
      );
    }
  }
}
