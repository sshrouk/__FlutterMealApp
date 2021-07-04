import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/categorymealscreen.dart';
import 'package:meal_app/screens/filter_Screen.dart';
import 'package:meal_app/screens/mealdetailsscreen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Map<String, bool> _filter = {
    'gluten': false,
    'vegan': false,
    'vegetarian': false,
    'lactoseFree': false,
  };
  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _setFilter(Map<String, bool> _filterData) {
    setState(() {
      _filter = _filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filter['gluten'] && meal.isGlutenFree == false) {
          return false;
        }
        if (_filter['vegetarian'] && meal.isVegetarian == false) {
          return false;
        }
        if (_filter['lactoseFree'] && meal.isLactoseFree == false) {
          return false;
        }
        if (_filter['vegan'] && meal.isVegan == false) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _togglefavorite(String mealId) {
    final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    } else {
      _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 245, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(255, 245, 229, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(255, 245, 229, 1),
              ),
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(_favoriteMeal),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(_availableMeal),
        MealDetailsScreen.routeName: (context) =>
            MealDetailsScreen(_togglefavorite,_isMealFavorite),
        FilterScreen.routeName: (context) => FilterScreen(_setFilter, _filter),
      },
    );
  }
}
