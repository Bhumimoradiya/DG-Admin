import 'dart:developer';

import 'package:dg_admin/db/brand.dart';
import 'package:dg_admin/db/category.dart';
import 'package:dg_admin/screens/add_product.dart';
import 'package:dg_admin/screens/brandList.dart';
import 'package:dg_admin/screens/categoryList.dart';
import 'package:dg_admin/screens/productList.dart';
import 'package:flutter/material.dart';

class Manage extends StatefulWidget {
  const Manage({super.key});

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  List field = [
    "Add product",
    "Product list",
    "Add category",
    "Category list",
    "Add brand",
    "brand list",
  ];
  List icons = [
    Icon(Icons.add),
    Icon(Icons.change_history),
    Icon(Icons.add_circle),
    Icon(Icons.category),
    Icon(Icons.add_circle_outline),
    Icon(Icons.library_books),
  ];
  GlobalKey _categoryformkey = GlobalKey();
  GlobalKey _brandformkey = GlobalKey();

  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
            // height: height * 0.42,
            height: 450,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Add product"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AddProudct()));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.change_history),
                  title: Text("Product list"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => productList()));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.add_circle),
                  title: Text("Add category"),
                  onTap: () {
                    _categoryalert();
                  },
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => categoryList()));
                  },
                  leading: Icon(Icons.category),
                  title: Text("Category list"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.add_circle_outline),
                  title: Text("Add brand"),
                  onTap: () {
                    _brandalert();
                  },
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => brandList()));
                  },
                  leading: Icon(Icons.library_books),
                  title: Text("brand list"),
                ),
                Divider(),
              ],
            )
           
            ),
      ),
    );
  }

  void _categoryalert() {
    var alert = AlertDialog(
      content: Form(
        key: _categoryformkey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'category can not be empty';
            }
            return null;
          },
          decoration: InputDecoration(helperText: "add category"),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            if (categoryController.text != null) {
              _categoryService.createCateory(categoryController.text);
            }
            log("category created");
            Navigator.pop(context);
          },
          icon: Icon(Icons.check),
          label: Text("Add"),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          label: Text("Cancel"),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _brandalert() {
    var alert = AlertDialog(
      content: Form(
        key: _brandformkey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'category can not be empty';
            }
          },
          decoration: InputDecoration(helperText: "add brand"),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            if (brandController.text != null) {
              _brandService.createBrand(brandController.text);
            }
            log("Brand created");
            Navigator.pop(context);
          },
          icon: Icon(Icons.check),
          label: Text("Add"),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          label: Text("Cancel"),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
