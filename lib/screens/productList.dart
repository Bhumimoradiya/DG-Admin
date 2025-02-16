import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dg_admin/db/product.dart';
import 'package:flutter/material.dart';

class productList extends StatefulWidget {
  const productList({super.key});

  @override
  State<productList> createState() => _productListState();
}

class _productListState extends State<productList> {
  ProductService _productService = ProductService();
  List<DocumentSnapshot> products = <DocumentSnapshot>[];
  String _currentProduct = '';
  Set<String> uniqueValues = Set<String>();
  List<DropdownMenuItem<String>> getProductDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < products.length; i++) {
      String productValue = products[i].get('name');
      if (!uniqueValues.contains(productValue)) {
        log("length : $productValue");
        setState(() {
          items.add(DropdownMenuItem(
            child: Text(productValue),
            value: productValue,
          ));
        });
        uniqueValues.add(productValue);
      }
    }
    return items;
  }

  _getproducts() async {
    List<DocumentSnapshot> data = await _productService.getProduct();
    setState(() {
      // print(data.length);
      products = data;
      // productsDropdown = getproductsDropdown();
      _currentProduct = products[0].get('name');
      print('current product : ${_currentProduct}');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getproducts();
    _currentProduct = products.isNotEmpty ? products[0].get('name') : '';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        backgroundColor: Colors.white,
        title: Text("Product List"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              // Divider(),
              ListTile(
                title: Text(products[index]['name']),
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}
