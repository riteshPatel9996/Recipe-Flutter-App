import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_flutter/app/config/Theme/app_theme.dart';

import '../../../../utils/widgets/appbar.dart';
import '../../../../utils/widgets/custom_textbox.dart';
import '../../../../utils/widgets/loader.dart';
import '../../../../utils/widgets/responsive_text.dart';
import '../../../../utils/widgets/rounded_corner_button.dart';
import '../../controller/i_controller.dart';

class AddIngredient extends StatelessWidget {
  AddIngredient({super.key});

  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    IngredientController ingredientController = Get.put(IngredientController());
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
            ingredientController.isLoading.value
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
                                'Name', const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 5),
                            CustomTextBox(
                              controller: ingredientController.iNameController,
                              validator: (val) {
                                if (val == '') {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            ResponsiveHeaderText(
                                'Measure Unit', const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 5),
                            CustomTextBox(
                              controller: ingredientController.iMeasureUnitController,
                              validator: (val) {
                                if (val == '') {
                                  return 'Please enter measure unit';
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
                                await ingredientController.pickImage(context);
                              },
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ResponsiveHeaderText(ingredientController.selectedImage.value,
                                        const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 10),
                                    ingredientController.selectedImage.value != 'Tap here for upload image'
                                        ? Image.file(ingredientController.image!)
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
                                  if (_formKey.currentState!.validate()) {
                                    await ingredientController.uploadIngredientData(
                                        ingredientController.iNameController.text,
                                        ingredientController.iMeasureUnitController.text,
                                        context,
                                        ingredientController.image);
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
