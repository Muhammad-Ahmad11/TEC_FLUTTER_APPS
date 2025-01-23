import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:task_03/models/post_model.dart';
import 'package:task_03/utils/Utils.dart';

class PostController extends GetxController {
  var postList = <PostModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxString errMessage = "".obs;
  RxBool isLastPage = false.obs;
  RxString search = ''.obs;
  int currentPage = 1;
  final int pageSize = 10;
  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchPosts(true);
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchPosts(bool isRefresh) async {
    if (isLoading.value) return;

    isLoading.value = true;
    isError.value = false;

    if (isRefresh) {
      postList.clear();
      currentPage = 1;
      isLastPage.value = false;
    }

    try {
      final response = await dio.get(
        Utils.postAPI_URL,
        queryParameters: {'_page': currentPage, '_limit': pageSize},
      );

      List<PostModel> fetchedPosts = (response.data as List)
          .map((post) => PostModel.fromJson(post))
          .toList();

      if (fetchedPosts.isEmpty) {
        isLastPage.value = true;
      } else {
        postList.addAll(fetchedPosts);
        currentPage++;
      }
    } catch (e) {
      isError.value = true;
      errMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  List<PostModel> get searchedPost {
    if (search.value.isEmpty) {
      return postList;
    } else {
      return postList
          .where((post) =>
              post.title.toLowerCase().contains(search.value.toLowerCase()))
          .toList();
    }
  }

  void retry() {
    fetchPosts(true);
  }
}
