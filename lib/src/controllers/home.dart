import 'package:get/get.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/category.dart';
import 'package:greengrocer/src/models/product.dart';
import 'package:greengrocer/src/repositories/home.dart';
import 'package:greengrocer/src/results/home.dart';

class HomeController extends GetxController {
  RxString searchProductName = ''.obs;

  final homeRepository = HomeRepository();

  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<Category> allCategories = [Category(id: 'Todos', name: 'Todos')];
  List<Product> products = [];
  late Category currentCategory;
  int page = 0;

  @override
  void onInit() {
    super.onInit();
    currentCategory = allCategories.firstWhereOrNull((cat) => cat.id == '') ??
        Category(id: 'Todos', name: 'Todos');
    debounce(
      searchProductName,
      (value) => filterByName(),
      time: const Duration(milliseconds: 600),
    );
    getAllCategories();
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (isProduct) {
      isProductLoading = value;
    } else {
      isCategoryLoading = value;
    }
    update();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    allCategories = [Category(id: 'Todos', name: 'Todos')];
    HomeResult<Category> homeResult = await homeRepository.getAllCategories();
    setLoading(false);

    homeResult.when(
      success: (category) {
        allCategories.addAll(category);
        if (allCategories.isEmpty) {
          return;
        } else {
          selectCategory(allCategories.firstWhere((c) => c.id == 'Todos'));
        }
      },
      error: (message) {
        MethodsUtils.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  void selectCategory(Category category) {
    currentCategory = category;
    products.clear();
    update();
    page = 0;
    gelAllProducts();
  }

  Future<void> gelAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    HomeResult<Product> result;

    if (searchProductName.value.isNotEmpty) {
      result = await homeRepository.getAllProducts(
        page: page,
        category: currentCategory,
        searchName: searchProductName.value,
        itemsPerPage: ConfigPage.itemsPerPage,
      );
    } else {
      result = await homeRepository.getAllProducts(
        page: page,
        category: currentCategory,
        itemsPerPage: ConfigPage.itemsPerPage,
      );
    }

    setLoading(false, isProduct: true);

    result.when(
      success: (product) {
        products.addAll(product);
      },
      error: (message) {
        MethodsUtils.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  bool get isLastPage {
    if (products.length < ConfigPage.itemsPerPage) {
      return true;
    }
    return page * ConfigPage.itemsPerPage > products.length;
  }

  void loadMoreProducts() {
    page++;
    gelAllProducts(canLoad: false);
  }

  void filterByName() {
    if (searchProductName.value.isNotEmpty) {
      //allCategories.removeWhere((cat) => cat.id != 'Todos');
      products.clear();
      page = 0;
    } else {
      getAllCategories();
    }
    currentCategory =
        allCategories.firstWhereOrNull((cat) => cat.id == 'Todos') ??
            Category(id: 'Todos', name: 'Todos');
    gelAllProducts();
  }
}
