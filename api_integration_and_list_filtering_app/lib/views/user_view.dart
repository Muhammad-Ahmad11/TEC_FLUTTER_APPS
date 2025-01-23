import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:task_03/controllers/user_controller.dart';
import 'package:task_03/models/user_model.dart';
import 'package:task_03/theme/colors.dart';
import 'package:task_03/utils/Utils.dart';

class UserView extends StatelessWidget {
  final userController = Get.put(UserController());
  final scrollController = Get.put(ScrollController());
  UserView({super.key});

  @override
  Widget build(BuildContext context) {
    //userController.fetchUsers(false);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !userController.isLastPage.value &&
          !userController.isLoading.value) {
        userController.fetchUsers(false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(Utils.userViewTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: Utils.userQueryHint,
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                userController.search.value = value;
              },
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (userController.isLoading.value &&
                    userController.userList.isEmpty) {
                  return _buildCircularIndicator();
                }

                if (userController.isError.value) {
                  return _buildRetryButton();
                }

                if (userController.userList.isEmpty) {
                  return _buildNoUsersWidget(Utils.noUsersFound);
                }

                return _buildListView();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetryButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Utils.errText + userController.errMessage.value),
          ElevatedButton(
            onPressed: userController.retry,
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
      itemCount: userController.searchedUser.length,
      itemBuilder: (context, index) {
        if (index <= userController.searchedUser.length) {
          UserModel user = userController.searchedUser[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
          );
        } else {
          if (!userController.isLastPage.value) {
            _buildCircularIndicator();
          } else {
            _buildNoUsersWidget(Utils.noMoreUsers);
          }
        }
      },
    );
  }

  Widget _buildCircularIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildNoUsersWidget(String text) {
    return Center(
        child: Text(text, style: const TextStyle(color: AppColors.greyColor)));
  }
}
