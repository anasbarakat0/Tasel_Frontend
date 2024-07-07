import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyDropdownMenu extends StatefulWidget {
  final Function(String) onCategorySelected;

  MyDropdownMenu({required this.onCategorySelected});

  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  List<String> _categories = [];
  List<String> _filteredCategories = [];
  String? _selectedCategory;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCategories);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://tasel-backend-g6gsdfug6a-uc.a.run.app/categories'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _categories = data.map((item) => item as String).toList();
        _filteredCategories = _categories;
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void _filterCategories() {
    setState(() {
      _filteredCategories = _categories
          .where((category) => category
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: DropdownButton<String>(
            value: _selectedCategory,
            hint: const Text('Select a Category...'),
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              setState(
                () {
                  _selectedCategory = newValue;
                  widget.onCategorySelected(newValue!);
                },
              );
            },
            items: _filteredCategories
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String? _selectedCategory;

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyDropdownMenu(onCategorySelected: _onCategorySelected),
        SizedBox(height: 20),
        Text(
          _selectedCategory != null
              ? 'Selected Category: $_selectedCategory'
              : 'No category selected',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
