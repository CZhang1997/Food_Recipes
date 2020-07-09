import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';
  final Function saveFilters;
  Map<String, bool> filter;

  FilterScreen(this.filter, this.saveFilters);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.filter['gluten'];
    _vegetarian = widget.filter['vegetarian'];
    _vegan = widget.filter['vegan'];
    _lactoseFree = widget.filter['lactose'];
  }

  Widget buildSwitchListTile(String title, bool currentValue, String subtitle,
      Function onChangeHandler) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: onChangeHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Map<String, bool> filter = {
                'gluten': _glutenFree,
                'lactose': _vegetarian,
                'vegan': _vegan,
                'vegetarian': _lactoseFree
              };
              widget.saveFilters(filter);
            },
          )
        ],
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Adjust your meal selection",
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              buildSwitchListTile(
                'Gluten-Free',
                _glutenFree,
                'Only include gluten-free meal',
                (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                'Lactose-Free',
                _lactoseFree,
                'Only include Lactose-free meal',
                (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                'Vegetarian',
                _vegetarian,
                'Only include Vegetarian meal',
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              buildSwitchListTile(
                'Vegen',
                _vegan,
                'Only include vegan meal',
                (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
            ],
          ),
        )
      ]),
      drawer: MainDrawer(),
    );
  }
}
