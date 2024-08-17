import 'package:greengrocer/src/helpers/data_table_keys/columns/categories.dart';
import 'package:greengrocer/src/helpers/data_table_keys/tables.dart';
import 'package:greengrocer/src/helpers/utils/parse_errors.dart';
import 'package:greengrocer/src/models/category.dart';
import 'package:greengrocer/src/results/home.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class HomeRepository {
  Future<HomeResult<Category>> getCategories() async {
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
}
