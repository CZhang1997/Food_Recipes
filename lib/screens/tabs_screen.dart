import 'package:Food_Recipes/models/meal.dart';
import 'package:flutter/material.dart';

import 'categories_screen.dart';
import 'favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TapScreen extends StatefulWidget {
  List<Meal> _favoriteMeals;
  TapScreen(this._favoriteMeals);

  @override
  _TapScreenState createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  @override
  Widget build(BuildContext context) {
    return tapOntheBottom(context);
  }

  List<Map<String, Object>> _pages2;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages2 = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget._favoriteMeals), 'title': 'Favorite'}
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget tapOntheBottom(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages2[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages2[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
              // backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text("Categories")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text("Favorite")),
        ],
      ),
    );
  }

  Widget tapOnTheTop() {
    return DefaultTabController(
      length: 2,
      // initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.category), text: "Categories"),
              Tab(icon: Icon(Icons.favorite), text: 'Favorite'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesScreen(),
            FavoritesScreen(widget._favoriteMeals)
          ],
        ),
      ),
    );
  }
}
