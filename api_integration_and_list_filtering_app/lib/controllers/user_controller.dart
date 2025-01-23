import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:task_03/models/user_model.dart';
import 'package:task_03/utils/Utils.dart';

class UserController extends GetxController {
  var userList = <UserModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxString errMessage = "".obs;
  RxBool isLastPage = false.obs;
  RxString search = ''.obs;
  int currentPage = 1;
  final int pageSize = 3;
  final Dio dio = Dio();

  @override
  void onInit() {
    fetchUsers(true);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchUsers(bool isRefresh) async {
    if (isRefresh) {
      userList.clear();
      currentPage = 1;
      isLastPage.value = false;
    }

    if (isLoading.value || isLastPage.value) return;

    try {
      isLoading.value = true;
      isError.value = false;

      final response = await dio.get(
        Utils.userAPI_URL,
        //queryParameters: {'page': 1},
      );

      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data'];
        if (list.isNotEmpty) {
          userList
              .addAll(list.map((data) => UserModel.fromJson(data)).toList());

          if (response.data['total_pages'] <= currentPage) {
            isLastPage.value = true;
          } else {
            currentPage++;
            //fetchUsers();
          }
        } else {
          isLastPage.value = true;
        }
      } else {
        isError.value = true;
        errMessage.value = 'Failed to load more data: ${response.statusCode}';
      }
    } catch (e) {
      isError.value = true;
      errMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  List<UserModel> get searchedUser {
    if (search.value.isEmpty) {
      return userList;
    } else {
      return userList
          .where((user) =>
              user.firstName
                  .toLowerCase()
                  .contains(search.value.toLowerCase()) ||
              user.lastName.toLowerCase().contains(search.value.toLowerCase()))
          .toList();
    }
  }

  void retry() {
    fetchUsers(true);
  }
}
