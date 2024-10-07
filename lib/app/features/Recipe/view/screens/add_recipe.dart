import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_flutter/app/config/Theme/app_theme.dart';

import '../../../../utils/widgets/appbar.dart';
import '../../../../utils/widgets/custom_textbox.dart';
import '../../../../utils/widgets/loader.dart';
import '../../../../utils/widgets/responsive_text.dart';
import '../../../../utils/widgets/rounded_corner_button.dart';
import '../../controller/r_controller.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  //form key
  final _formKey = GlobalKey<FormState>();
  RecipeController recipeController = Get.put(RecipeController());

  @override
  void initState() {
    // TODO: implement initState
    recipeController.loadIngredientList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //common app bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        // here the desired height
        child: AppBarWidget(),
      ),
      body: Obx(
        () => Stack(
          children: [
            recipeController.isLoading.value
                ? const Loader()
                : Container(
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text('Please fill the details',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20)),
                            const SizedBox(height: 20),
                            ResponsiveHeaderText(
                                'Name*', const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 5),
                            CustomTextBox(
                              controller: recipeController.rNameController,
                              validator: (val) {
                                if (val == '') {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () {
                                recipeController.showMultiSelectDialog(context);
                              },
                              child: ResponsiveHeaderText(
                                'Select Ingredient*',
                                const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Wrap(
                              children: [
                                for (int i = 0; i < recipeController.selectedIngredientDocument.value.length; i++)
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      recipeController.selectedIngredientDocument[i]['name'].toString(),
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  )
                              ],
                            ),
                            const SizedBox(height: 5),
                            ResponsiveHeaderText(
                                'Description*', const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 5),
                            CustomTextBox(
                              maxLines: 3,
                              controller: recipeController.rDescriptionController,
                              validator: (val) {
                                if (val == '') {
                                  return 'Please enter description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            ResponsiveHeaderText(
                                'Instruction*', const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 5),
                            CustomTextBox(
                              maxLines: 3,
                              controller: recipeController.rInstructionController,
                              validator: (val) {
                                if (val == '') {
                                  return 'Please enter instruction';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            ResponsiveHeaderText(
                                'Upload image', const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                await recipeController.pickImage(context);
                              },
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ResponsiveHeaderText(recipeController.selectedImage.value,
                                        const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 10),
                                    recipeController.selectedImage.value != 'Tap here for upload image'
                                        ? Image.file(recipeController.image!)
                                        : const Offstage()
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: RoundedCornerButton(
                                onPressed: () async {
                                  if (recipeController.selectedIngredientDocument.isNotEmpty) {
                                    List tempIngredientList = [];
                                    for (int i = 0; i < recipeController.selectedIngredientDocument.length; i++) {
                                      tempIngredientList
                                          .add({'id': recipeController.selectedIngredientDocument[i]['id']});
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      await recipeController.uploadRecipeData(
                                          recipeController.rNameController.text,
                                          recipeController.rDescriptionController.text,
                                          recipeController.rInstructionController.text,
                                          tempIngredientList,
                                          context,
                                          recipeController.image);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(content: Text('Please select ingredients')));
                                  }
                                },
                                buttonColor: AppTheme.appConstColor,
                                roundedCorner: 15.00,
                                title: 'Upload',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
