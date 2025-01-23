import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:task_03/controllers/post_controller.dart';
import 'package:task_03/models/post_model.dart';
import 'package:task_03/theme/colors.dart';
import 'package:task_03/utils/Utils.dart';

class PostView extends StatelessWidget {
  final postController = Get.put(PostController());
  final scrollController = Get.put(ScrollController());
  PostView({super.key});

  @override
  Widget build(BuildContext context) {
    //PostController.fetchPosts(false);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !postController.isLastPage.value &&
          !postController.isLoading.value) {
        postController.fetchPosts(false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(Utils.postViewTitle),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(
              () {
                if (postController.isLoading.value &&
                    postController.postList.isEmpty) {
                  return _buildCircularIndicator();
                }

                if (postController.isError.value) {
                  return _buildRetryButton();
                }

                if (postController.postList.isEmpty) {
                  return _buildNoPostsWidget(Utils.noPostsFound);
                }

                return _buildListView();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: const InputDecoration(
          hintText: Utils.postQueryHint,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          postController.search.value = value;
        },
      ),
    );
  }

  Widget _buildRetryButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Utils.errText + postController.errMessage.value),
          ElevatedButton(
            onPressed: postController.retry,
            child: const Text(Utils.retry,
                style: TextStyle(color: AppColors.backgroundColor)),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      controller: scrollController,
      itemCount: postController.searchedPost.length,
      itemBuilder: (context, index) {
        if (index <= postController.searchedPost.length) {
          PostModel post = postController.searchedPost[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
          );
        } else {
          if (!postController.isLastPage.value) {
            _buildCircularIndicator();
          } else {
            _buildNoPostsWidget(Utils.noMorePosts);
          }
        }
      },
    );
  }

  Widget _buildCircularIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildNoPostsWidget(String text) {
    return Center(
        child: Text(text, style: const TextStyle(color: AppColors.greyColor)));
  }
}
