import 'package:get/get.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/category.dart';
import 'package:greengrocer/src/models/product.dart';
import 'package:greengrocer/src/repositories/home.dart';
import 'package:greengrocer/src/results/home.dart';

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<Category> allCategories = [];
  List<Product> products = [];
  Category? currentCategory;
  int page = 0;

  @override
  void onInit() {
    super.onInit();
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
    HomeResult<Category> homeResult = await homeRepository.getAllCategories();
    setLoading(false);

    homeResult.when(
      success: (category) {
        allCategories.assignAll(category);
        if (allCategories.isEmpty) {
          return;
        } else {
          selectCategory(allCategories.firstWhere((c) => c.name == 'Frutas'));
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

    String search = '';
    Category category = Category(id: 'AHu5fWo4RS', name: 'Frutas');

    HomeResult<Product> result = await homeRepository.getAllProducts(
      page: page,
      searchName: search,
      category: currentCategory ?? category,
      itemsPerPage: ConfigPage.itemsPerPage,
    );
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

  List<Product> get allProducts => products;

  bool get isLastPage {
    if (products.length < ConfigPage.itemsPerPage) {
      return true;
    }
    return page * ConfigPage.itemsPerPage > allProducts.length;
  }

  void loadMoreProducts() {
    page++;
    gelAllProducts(canLoad: false);
  }
}
