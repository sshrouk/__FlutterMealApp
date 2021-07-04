import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/mealitem.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = 'category_meals';
  final List<Meal> availableMeal;

  CategoryMealScreen(this.availableMeal);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayMeals;

  @override
  void didChangeDependencies() {
    final routeArg = ModalRoute.of(context).settings.arguments
        as Map<String, String>; //bfk d3't  id w title ll gyen men categoryitem
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];
    displayMeals = widget.availableMeal.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        //ListView bstzdm el map  \\ ListView.builder msh bstzdm el map
        itemBuilder: (ctx, index) {
          print(displayMeals[index].title);
          return MealItem(
            id: displayMeals[index].id,
            imageUrl: displayMeals[index].imageUrl,
            duration: displayMeals[index].duration,
            title: displayMeals[index].title,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
           // removeItem: _removeMeal,
          );
        }, // bn2 el 3nser
        itemCount: displayMeals.length, //3ddh
      ),
    );
  }
}
