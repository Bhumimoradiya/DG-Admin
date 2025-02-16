import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dg_admin/db/brand.dart';
import 'package:flutter/material.dart';

class brandList extends StatefulWidget {
  const brandList({super.key});

  @override
  State<brandList> createState() => _brandListState();
}

class _brandListState extends State<brandList> {
  Set<String> branduniqueValues = Set<String>();
  List<DropdownMenuItem<String>> brandsDropdown = <DropdownMenuItem<String>>[];
  String _currentBrand = '';
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  BrandService _brandService = BrandService();

  List<DropdownMenuItem<String>> items = [];
  List<DropdownMenuItem<String>> getbrandDropdown() {
    for (int i = 0; i < brands.length; i++) {
      String brandValue = brands[i].get('brand');
      if (!branduniqueValues.contains(brandValue)) {
        log("length brand: $brandValue");
        setState(() {
          items.add(DropdownMenuItem(
            child: Text(brandValue),
            value: brandValue,
          ));
        });
        branduniqueValues.add(brandValue);
      }
    }
    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getbrand();
    _currentBrand = brands.isNotEmpty ? brands[0].get('brand') : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey.shade200,
        backgroundColor: Colors.white,
        title: Text("Brand List"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
      ),
      body: ListView.builder(
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              // Divider(),
              ListTile(
                title: Text(brands[index]['brand']),
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }

  _getbrand() async {
    List<DocumentSnapshot> data = await _brandService.getbrands();
    setState(() {
      // print(data.length);
      brands = data;
      brandsDropdown = getbrandDropdown();
      _currentBrand = brands[0].get('brand');
      print('current brand : ${_currentBrand}');
      print('current brand length : ${_currentBrand.length}');
    });
  }
}
