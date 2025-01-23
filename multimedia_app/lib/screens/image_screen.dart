import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimedia_app/utils/utils.dart';
import '../controllers/image_controller.dart';

class ImageScreen extends StatelessWidget {
  final imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Utils.imageScreenName),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Obx(() {
          if (imageController.selectedImage.value.path.isEmpty) {
            return const Text(Utils.noImageSelectedText);
          } else {
            return Image.file(imageController.selectedImage.value);
          }
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: imageController.pickImage,
            child: const Icon(Icons.add_a_photo),
            heroTag: 'pick',
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => imageController.applyFilter(context),
            child: const Icon(Icons.filter),
            heroTag: 'filter',
          ),
        ],
      ),
    );
  }
}
