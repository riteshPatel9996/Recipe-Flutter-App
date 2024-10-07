import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/widgets/appbar.dart';
import '../../../../utils/widgets/custom_textbox.dart';
import '../../../../utils/widgets/loader.dart';
import '../../../../utils/widgets/no_data_found.dart';
import '../../../../utils/widgets/responsive_text.dart';
import '../widgets/recipe_list.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //common app bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        // here the desired height
        child: AppBarWidget(
          title: ResponsiveHeaderText(
            'Recipe List',
            const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed('/addRecipe');
              },
            ),
          ],
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
          return Column(
            children: [
              const SizedBox(height: 10),
              const CustomTextBox(
                  //controller: ingredientController.iSearchQuery,
                  ),
              const SizedBox(height: 10),
              Expanded(
                  child: documents.isNotEmpty
                      ? ListView.builder(
                          itemCount: documents.length, // Number of items in the list
                          itemBuilder: (context, index) {
                            return RecipesList(documentSnapshot: documents[index], index: index);
                          },
                        )
                      : const NoDataFound())
            ],
          );
        },
      ),
    );
  }
}
