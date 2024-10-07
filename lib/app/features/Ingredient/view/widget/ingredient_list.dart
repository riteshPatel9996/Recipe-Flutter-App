import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipes_flutter/app/config/Theme/app_theme.dart';

import '../../controller/i_controller.dart';

class IngredientsList extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  int index;

  IngredientsList({super.key, required this.documentSnapshot, required this.index});

  @override
  State<IngredientsList> createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IngredientController ingredientController = Get.put(IngredientController());
    Uint8List? imageBytes;
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
                  'Measure type' ': ${widget.documentSnapshot['units'].toString()}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    ingredientController.showBottomSheet(
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
