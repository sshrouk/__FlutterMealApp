import 'package:flutter/material.dart';
import 'package:meal_app/widgets/maindrawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilter;
  final Map<String, bool> currentFulters;

  FilterScreen(this.saveFilter, this.currentFulters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGlutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;
@override
initState(){
   _isGlutenFree = widget.currentFulters['gluten'];
   _isVegan = widget.currentFulters['vegan'];
   _isVegetarian = widget.currentFulters['vegetarian'];
   _isLactoseFree = widget.currentFulters['lactoseFree'];
  super.initState();
}
  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Filters",
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _isGlutenFree,
                  'vegan': _isVegan,
                  'vegetarian': _isVegetarian,
                  'lactoseFree': _isLactoseFree,
                };
                widget.saveFilter(selectedFilters);
              })
        ],
      ),
      body: Column(
        children: [
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
                  'GlutenFree',
                  'Only include gluten_free meal',
                  _isGlutenFree,
                  (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'vegan',
                  'Only include vegan meal',
                  _isVegan,
                  (newValue) {
                    setState(() {
                      _isVegan = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'vegetarian',
                  'Only include vegetarian meal',
                  _isVegetarian,
                  (newValue) {
                    setState(() {
                      _isVegetarian = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'lactoseFree',
                  'Only include lactoseFree meal',
                  _isLactoseFree,
                  (newValue) {
                    setState(() {
                      _isLactoseFree = newValue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
