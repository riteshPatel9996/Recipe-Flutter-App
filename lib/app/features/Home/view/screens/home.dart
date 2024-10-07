import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../config/Theme/app_theme.dart';
import '../../../../utils/widgets/appbar.dart';
import '../../../../utils/widgets/loader.dart';
import '../../../../utils/widgets/no_data_found.dart';
import '../../../../utils/widgets/responsive_text.dart';

class Home extends StatelessWidget {
  // Dummy recipe data
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        // here the desired height
        child: AppBarWidget(
          title: ResponsiveHeaderText(
            'Dashboard',
            const TextStyle(color: Colors.white),
          ),
          actions: const [],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('recipe').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader(); // Loading indicator
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('/ingredient');
                      },
                      child: ResponsiveHeaderText(
                        'Ingredient',
                        const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/recipe');
                      },
                      child: ResponsiveHeaderText(
                        'Recipe',
                        const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                documents.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 1, // 2 columns
                          //   crossAxisSpacing: 10,
                          //   mainAxisSpacing: 10,
                          //   childAspectRatio: 0.8, // Adjust this to fit images well
                          // ),
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return RecipeContainer(documentSnapshot: documents[index]);
                          },
                        ),
                      )
                    : const NoDataFound(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RecipeContainer extends StatelessWidget {
  RecipeContainer({
    super.key,
    required this.documentSnapshot,
  });

  DocumentSnapshot documentSnapshot;

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    Uint8List? imageBytesIngredients;
    if (documentSnapshot['base64Image'] != null) {
      imageBytes = base64Decode(documentSnapshot['base64Image'].toString());
    }
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: imageBytes != null
                ? Image.memory(imageBytes, fit: BoxFit.fill, height: 280)
                : Image.network(
                    'https://static.everypixel.com/ep-pixabay/0329/8099/0858/84037/3298099085884037069-head.png',
                    fit: BoxFit.fill,
                    height: 280),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentSnapshot['name']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.timer, size: 16, color: Colors.black),
                    SizedBox(width: 5),
                    Text(
                      '40 min',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.star, size: 16, color: Colors.black),
                    SizedBox(width: 5),
                    Text(
                      '4.5',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                // const SizedBox(height: 8),
                // const Row(
                //   children: [
                //
                //   ],
                // ),
                const SizedBox(height: 8),
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
                    itemCount: documentSnapshot['ingredients'].length,
                    // Number of items in the grid
                    itemBuilder: (context, index) {
                      if (documentSnapshot['ingredients'][index]['base64Image'] != null) {
                        imageBytesIngredients =
                            base64Decode(documentSnapshot['ingredients'][index]['base64Image'].toString());
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
                              padding: const EdgeInsets.all(5),
                              //  width: 25,
                              // Set width and height equal to make it a circle
                              // height: 25,
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
                            Expanded(
                              child: Text(
                                documentSnapshot['ingredients'][index]['name'],
                                style: TextStyle(
                                    color: AppTheme.appConstColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.description, size: 16, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(
                      documentSnapshot['description']!.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.integration_instructions, size: 16, color: Colors.black),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        documentSnapshot['instruction']!.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
