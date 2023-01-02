import 'package:get/get.dart';

class LoadController extends GetxController {
  final RxBool isLoading = false.obs;
  void change() {
    isLoading.value = !isLoading.value;
  }
}
