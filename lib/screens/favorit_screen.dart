import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/mealitem.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeal;

  FavoritesScreen(this.favoriteMeal);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
      return Center(
        child: Text(
          "You have no favorites yet - start adding some!",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      );
    } else {
      return ListView.builder(
        //ListView bstzdm el map  \\ ListView.builder msh bstzdm el map
        itemBuilder: (ctx, index) {
          print(favoriteMeal[index].title);
          return MealItem(
            id: favoriteMeal[index].id,
            imageUrl: favoriteMeal[index].imageUrl,
            duration: favoriteMeal[index].duration,
            title: favoriteMeal[index].title,
            complexity: favoriteMeal[index].complexity,
            affordability: favoriteMeal[index].affordability,
          );
        }, // bn2 el 3nser
        itemCount: favoriteMeal.length, //3ddh
      );
    }
  }
}
