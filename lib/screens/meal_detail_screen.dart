import 'package:flutter/material.dart';

import 'category_meals_screen.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Function _toggleFavorite;
  final Function _isMealFavorite;
  MealDetailScreen(this._toggleFavorite, this._isMealFavorite);
  static final String routeName =
      CategoryMealsScreen.routeName + "/meal_details";

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              meal.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(
            ListView.builder(
              itemCount: meal.ingredients.length,
              itemBuilder: (ctx, index) => Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(meal.ingredients[index]),
                ),
                color: Theme.of(ctx).accentColor,
              ),
            ),
          ),
          buildSectionTitle(context, 'Steps'),
          buildContainer(ListView.builder(
            itemBuilder: (ctx, index) => Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Text('# ${index + 1}'),
                  ),
                  title: Text(meal.steps[index]),
                ),
                Divider()
              ],
            ),
            itemCount: meal.steps.length,
          )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isMealFavorite(meal.id) ? Icons.star : Icons.star_border),
        onPressed: () {
          _toggleFavorite(meal.id);
          //Navigator.of(context).pop(meal.id);
        },
      ),
    );
  }
}
