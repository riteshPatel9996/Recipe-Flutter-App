part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const ingredient = _Paths.ingredient;
  static const addIngredient = _Paths.addIngredient;

  static const recipe = _Paths.recipe;
  static const addRecipe = _Paths.addRecipe;

  static const home =_Paths.home;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const ingredient = '/ingredient';
  static const addIngredient = '/addIngredient';

  static const recipe = '/recipe';
  static const addRecipe = '/addRecipe';

  static const home ='/home';
}
