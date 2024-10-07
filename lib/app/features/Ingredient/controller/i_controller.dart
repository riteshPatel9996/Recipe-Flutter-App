import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/Theme/app_theme.dart';
import '../../../utils/widgets/rounded_corner_button.dart';

class IngredientController extends GetxController {
  //Loader variable
  RxBool isLoading = false.obs;
  RxString selectedImage = 'Tap here for upload image'.obs;

  //text editing controller
  final TextEditingController iNameController = TextEditingController();
  final TextEditingController iMeasureUnitController = TextEditingController();
  final TextEditingController iSearchQuery = TextEditingController();

  //for image picker variable
  File? image;
  final picker = ImagePicker();
  late String base64Image;

  //firebase variables
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Loading Ingredient list
  Future<void> loadIngrediantList() async {
    isLoading.value = true;

    isLoading.value = false;
  }

  //Image upload function
  Future<void> pickImage(context) async {
    isLoading.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      int fileSizeInBytes = File(pickedFile.path).lengthSync();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
      //check if image is greater by 1 mb or not

      if (fileSizeInMB <= 1) {
        image = File(pickedFile.path);
        selectedImage.value = image!.path
            .toString()
            .substring(image!.path.toString().lastIndexOf('/') + 1, image!.path.toString().length);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image size is greater than 1 MB')));
      }
    }
    isLoading.value = false;
  }

//Upload data into firebase
  Future<void> uploadIngredientData(name, units, context, [File? image]) async {
    isLoading.value = true;
    base64Image = '';
    try {
      Map<String, dynamic> body = {'name': name, 'units': units};
      // if (image != null) {

      if (selectedImage.value != 'Tap here for upload image') {
        final bytes = File(image!.path).readAsBytesSync();
        base64Image = base64Encode(bytes);
        // Create a unique file name for the image
        String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        body.addAll({'timestamp': DateTime.now()});
        body.addAll({'base64Image': base64Image, 'fileName': fileName});
      } else {
        body.addAll({'base64Image': null, 'fileName': null});
      }
      // }
      await FirebaseFirestore.instance.collection('Ingredients').add(body).whenComplete(() {
        iNameController.clear();
        iMeasureUnitController.clear();
        selectedImage.value = 'Tap here for upload image';
        isLoading.value = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ingredient saved')));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  showBottomSheet(heading, type, context, documentID, [subheading]) {
    return showModalBottomSheet<dynamic>(
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 30, bottom: 10, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                RoundedCornerButton(
                  roundedCorner: 20.0,
                  title: type,
                  onPressed: () async {
                    await deleteDocument(documentID).whenComplete(() {
                      Get.back();
                    });
                  },
                  buttonColor: AppTheme.appConstColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    'NO, CANCEL',
                    style: TextStyle(fontSize: 14, color: AppTheme.appConstColor, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  //delete ingredient
  Future<void> deleteDocument(String docId) async {
    isLoading.value = true;
    try {
      // Reference to the document in a collection, replace 'your_collection_name'
      await firestore.collection('Ingredients').doc(docId).delete();
    } catch (e) {}
    isLoading.value = false;
  }
}
