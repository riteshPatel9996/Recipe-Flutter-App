import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipes_flutter/app/config/Theme/app_theme.dart';
import 'package:recipes_flutter/app/features/Recipe/controller/r_controller.dart';

class RecipesList extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  int index;

  RecipesList({super.key, required this.documentSnapshot, required this.index});

  @override
  State<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RecipeController recipeController = Get.put(RecipeController());
    Uint8List? imageBytes;
    Uint8List? imageBytesIngredients;
    if (widget.documentSnapshot['base64Image'] != null) {
      imageBytes = base64Decode(widget.documentSnapshot['base64Image'].toString());
    }
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4), // Shadow position
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageBytes != null
              ? Image.memory(imageBytes, height: 100, width: 100)
              : Image.network(
                  'https://static.everypixel.com/ep-pixabay/0329/8099/0858/84037/3298099085884037069-head.png',
                  height: 100,
                  width: 100),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name' ': ${widget.documentSnapshot['name'].toString()}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  'Description' ': ${widget.documentSnapshot['description'].toString()}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  'Instruction' ': ${widget.documentSnapshot['instruction'].toString()}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 35,
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // Grid properties
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        // Number of columns in the grid
                        crossAxisSpacing: 5.0,
                        // Spacing between columns
                        mainAxisSpacing: 5.0,
                        // Spacing between rows
                        childAspectRatio: 1,
                        mainAxisExtent: 150 // Aspect ratio of each grid item
                        ),
                    itemCount: widget.documentSnapshot['ingredients'].length,
                    // Number of items in the grid
                    itemBuilder: (context, index) {
                      if (widget.documentSnapshot['ingredients'][index]['base64Image'] != null) {
                        imageBytesIngredients =
                            base64Decode(widget.documentSnapshot['ingredients'][index]['base64Image'].toString());
                      }
                      // Build each item of the grid
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              padding: const EdgeInsets.all(2),
                              width: 25,
                              // Set width and height equal to make it a circle
                              height: 25,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: imageBytesIngredients != null
                                  ? Image.memory(
                                      imageBytesIngredients!,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      'https://static.everypixel.com/ep-pixabay/0329/8099/0858/84037/3298099085884037069-head.png',
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            Text(
                              widget.documentSnapshot['ingredients'][index]['name'],
                              style:
                                  TextStyle(color: AppTheme.appConstColor, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    recipeController.showBottomSheet(
                        'Are you sure you want to Delete ?', 'Delete', context, widget.documentSnapshot.id.toString());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.delete,
                        color: AppTheme.appConstColor,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Delete',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
