import 'package:get/get.dart';
import 'package:greengrocer/src/helpers/utils/methods.dart';
import 'package:greengrocer/src/models/category.dart';
import 'package:greengrocer/src/repositories/home.dart';
import 'package:greengrocer/src/results/home.dart';

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  bool isLoading = false;
  List<Category> allCategories = [];

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    HomeResult<Category> homeResult = await homeRepository.getCategories();
    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        print(allCategories);
      },
      error: (message) {
        MethodsUtils.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
