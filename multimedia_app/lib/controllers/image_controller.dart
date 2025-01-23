import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multimedia_app/utils/utils.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'dart:io';

class ImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var selectedImage = File('').obs;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> applyFilter(BuildContext context) async {
    if (selectedImage.value.path.isNotEmpty) {
      try {
        final bytes = await selectedImage.value.readAsBytes();
        final image = imageLib.decodeImage(bytes);

        if (image == null) {
          Utils.unableToProcessImage();
          return;
        }

        final fileName = selectedImage.value.path.split('/').last;

        Map? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoFilterSelector(
              title: const Text(Utils.applyFilterText),
              image: image,
              filters: presetFiltersList,
              filename: fileName,
              loader: const Center(child: CircularProgressIndicator()),
            ),
          ),
        );

        if (result != null && result.containsKey(Utils.imageFilteredKey)) {
          var filteredResult = result[Utils.imageFilteredKey];

          if (filteredResult is imageLib.Image) {
            String newPath = selectedImage.value.path.replaceFirst(
              fileName,
              'filtered_$fileName',
            );
            File newImageFile = File(newPath)
              ..writeAsBytesSync(imageLib.encodeJpg(filteredResult));

            selectedImage.value = newImageFile;
          } else if (filteredResult is File) {
            selectedImage.value = filteredResult;
          } else {
            Utils.unknownFilteredImage();
          }
        }
      } catch (e) {
        Utils.errWhileApplyingFilter();
        debugPrint("Filter application error: $e");
      }
    }
  }
}
