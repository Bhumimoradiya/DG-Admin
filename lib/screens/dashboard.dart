import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dg_admin/db/brand.dart';
import 'package:dg_admin/db/category.dart';
import 'package:dg_admin/db/product.dart';
import 'package:dg_admin/db/userDetail.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Icon> icons = [
    Icon(
      Icons.people_outline,
      color: Colors.grey.shade700,
    ),
    Icon(Icons.category, color: Colors.grey.shade700),
    Icon(Icons.track_changes, color: Colors.grey.shade700),
    Icon(Icons.shopping_cart, color: Colors.grey.shade700),
    Icon(Icons.close, color: Colors.grey.shade700),
  ];
  int user = 0;
  List name = ["Users", "Categories", "Products", "Orders", "Return"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getcategories();
    _getproducts();
    _getbrand();
    _getuser();
  }

  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  CategoryService _categoryService = CategoryService();
  _getcategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      categories = data;
    });
  }

  ProductService _productService = ProductService();
  List<DocumentSnapshot> products = <DocumentSnapshot>[];
  _getproducts() async {
    List<DocumentSnapshot> data = await _productService.getProduct();
    setState(() {
      // print(data.length);
      products = data;
    });
  }

  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  BrandService _brandService = BrandService();
  _getbrand() async {
    List<DocumentSnapshot> data = await _brandService.getbrands();
    setState(() {
      // print(data.length);
      brands = data;
    });
  }

  List<DocumentSnapshot> users = <DocumentSnapshot>[];
  UserDetail _userDetail = UserDetail();

  _getuser() async {
    List<DocumentSnapshot> data = await _userDetail.allUSer();
    setState(() {
      users = data;
      log("Users length : ${users.length}");
    });
  }

  List<int> productnumber = [7, 23, 120, 5, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 165,
                width: 165,
                child: Card(
                  color: Colors.white, // color of grid items
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              color: Colors.grey.shade700,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Users",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            users.length.toString(),
                            style: TextStyle(
                                fontSize: 50, color: Colors.orangeAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 165,
                width: 165,
                child: Card(
                  color: Colors.white, // color of grid items
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.category, color: Colors.grey.shade700),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Categories",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            categories.length.toString(),
                            style: TextStyle(
                                fontSize: 50, color: Colors.orangeAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                height: 165,
                width: 165,
                child: Card(
                  color: Colors.white, // color of grid items
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.track_changes,
                                color: Colors.grey.shade700),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Products",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            products.length.toString(),
                            style: TextStyle(
                                fontSize: 50, color: Colors.orangeAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 165,
                width: 165,
                child: Card(
                  color: Colors.white, // color of grid items
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart,
                                color: Colors.grey.shade700),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Orders",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "0",
                            style: TextStyle(
                                fontSize: 50, color: Colors.orangeAccent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 165,
              width: 165,
              child: Card(
                color: Colors.white, // color of grid items
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.library_books),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Brands",
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          brands.length.toString(),
                          style: TextStyle(
                              fontSize: 50, color: Colors.orangeAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
