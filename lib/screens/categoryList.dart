import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dg_admin/db/category.dart';
import 'package:flutter/material.dart';

class categoryList extends StatefulWidget {
  const categoryList({super.key});

  @override
  State<categoryList> createState() => _categoryListState();
}

class _categoryListState extends State<categoryList> {
  List<DropdownMenuItem<String>> categoriesDropdown =
      <DropdownMenuItem<String>>[];
  String _currentCategory = '';
  Set<String> uniqueValues = Set<String>();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  CategoryService _categoryService = CategoryService();

  _getcategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      // print(data.length);
      categories = data;
      categoriesDropdown = getCategoriesDropdown();
      _currentCategory = categories[0].get('category');
      print('current category : ${_currentCategory}');
      print('current category Length : ${_currentCategory.length}');
    });
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < categories.length; i++) {
      String categoryValue = categories[i].get('category');
      if (!uniqueValues.contains(categoryValue)) {
        log("length : $categoryValue");
        setState(() {
          items.add(DropdownMenuItem(
            child: Text(categoryValue),
            value: categoryValue,
          ));
        });
        uniqueValues.add(categoryValue);
      }
    }
    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getcategories();
    _currentCategory =
        categories.isNotEmpty ? categories[0].get('category') : '';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        backgroundColor: Colors.white,
        title: Text("Category List"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              // Divider(),
              ListTile(
                title: Text(categories[index]['category']),
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}
