import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_flutter/app/utils/widgets/custom_textbox.dart';

import '../../../../utils/widgets/appbar.dart';
import '../../../../utils/widgets/loader.dart';
import '../../../../utils/widgets/no_data_found.dart';
import '../../../../utils/widgets/responsive_text.dart';
import '../../controller/i_controller.dart';
import '../widget/ingredient_list.dart';

class Ingredient extends StatefulWidget {
  const Ingredient({super.key});

  @override
  State<Ingredient> createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    IngredientController ingredientController = Get.put(IngredientController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //common app bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        // here the desired height
        child: AppBarWidget(
          title: ResponsiveHeaderText(
            'Ingredients List',
            const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed('/addIngredient');
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('Ingredients').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader(); // Loading indicator
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          List<DocumentSnapshot> filteredDocs = documents.where((doc) {
            String itemName = doc['name'].toString().toLowerCase();
            return itemName.contains(ingredientController.iSearchQuery.text.toLowerCase());
          }).toList();
          return Column(
            children: [
              const SizedBox(height: 10),
              CustomTextBox(
                controller: ingredientController.iSearchQuery,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: documents.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredDocs.isNotEmpty
                            ? filteredDocs.length
                            : documents.length, // Number of items in the list
                        itemBuilder: (context, index) {
                          return IngredientsList(
                              documentSnapshot: filteredDocs.isNotEmpty ? filteredDocs[index] : documents[index],
                              index: index);
                        },
                      )
                    : const NoDataFound(),
              )
            ],
          );
        },
      ),
    );
  }
}
