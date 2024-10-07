import 'package:get/get.dart';
import 'package:recipes_flutter/app/features/Recipe/view/screens/add_recipe.dart';

import '../../features/Home/view/screens/home.dart';
import '../../features/Ingredient/view/screens/add_ingredient.dart';
import '../../features/Ingredient/view/screens/ingredient.dart';
import '../../features/Recipe/view/screens/recipe.dart';

/// contains all configuration pages
part 'app_routes.dart';

class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.home;

  static final routes = [
    GetPage(name: _Paths.ingredient, page: () => const Ingredient(), transition: Transition.leftToRight),
    GetPage(name: _Paths.addIngredient, page: () => AddIngredient(), transition: Transition.leftToRight),
    GetPage(name: _Paths.recipe, page: () => const Recipe(), transition: Transition.leftToRight),
    GetPage(name: _Paths.addRecipe, page: () => const AddRecipe(), transition: Transition.leftToRight),
    GetPage(name: _Paths.home, page: () =>  Home(), transition: Transition.leftToRight),
  ];
}
