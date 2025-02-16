import 'dart:developer';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dg_admin/db/brand.dart';
import 'package:dg_admin/db/category.dart';
import 'package:dg_admin/db/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProudct extends StatefulWidget {
  const AddProudct({Key? key}) : super(key: key);

  @override
  State<AddProudct> createState() => _AddProudctState();
}

class _AddProudctState extends State<AddProudct> {
  final _formkey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> brandsDropdown = <DropdownMenuItem<String>>[];
  String _currentBrand = '';
  List<DropdownMenuItem<String>> categoriesDropdown =
      <DropdownMenuItem<String>>[];
  String _currentCategory = '';
  Set<String> uniqueValues = Set<String>();
  Set<String> branduniqueValues = Set<String>();

  TextEditingController productcontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  bool isLoading = false;
  File? img1;
  File? img2;
  File? img3;

  @override
  void initState() {
    super.initState();
    _getcategories();
    _getbrand();
    _currentCategory =
        categories.isNotEmpty ? categories[0].get('category') : '';
    _currentBrand = brands.isNotEmpty ? brands[0].get('brand') : '';
    // categoriesDropdown = getCategoriesDropdown();
    // _currentCategory = categoriesDropdown[0].value!;
  }

  List<DropdownMenuItem<String>> getbrandDropdown() {
    List<DropdownMenuItem<String>> items = [];
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add Product"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Colors.orangeAccent,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  selectedImage(
                                      picker.pickImage(
                                          source: ImageSource.gallery),
                                      1);
                                },
                                child: Container(
                                  height: 180,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.orangeAccent)),
                                  // image: DecorationImage(image: )
                                  child: _displaychild1(),
                                ),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  selectedImage(
                                      picker.pickImage(
                                          source: ImageSource.gallery),
                                      2);
                                },
                                child: Container(
                                  height: 180,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.orangeAccent)),
                                  // image: DecorationImage(image: )
                                  child: _displaychild2(),
                                ),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  selectedImage(
                                      picker.pickImage(
                                          source: ImageSource.gallery),
                                      3);
                                },
                                child: Container(
                                  height: 180,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.orangeAccent)),
                                  // image: DecorationImage(image: )
                                  child: _displaychild3(),
                                ),
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(
                        "Enter product name with 10 characters at minimum",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8,
                      ),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        controller: productcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You must enter the product name";
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Product Name",
                          labelText: "Product Name",
                          focusColor: Colors.orangeAccent,

                          // focusedBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //     borderSide: BorderSide(
                          //         color: Colors.orangeAccent, width: 1))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories : ",
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          DropdownButton(
                            items: categoriesDropdown,
                            onChanged: changeSelectedCategories,
                            value: _currentCategory,
                            // hint: Text('Select a category'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Brand : ",
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          DropdownButton(
                            items: brandsDropdown,
                            onChanged: changeSelectedBrand,
                            value: _currentBrand,
                            // hint: Text('Select a brand'),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8,
                      ),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        controller: quantitycontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You must enter the Quantity";
                          }
                        },
                        keyboardType: TextInputType.number,
                        // initialValue: '1',
                        decoration: InputDecoration(
                          hintText: "Quantity",
                          labelText: "Quantity",

                          focusColor: Colors.orangeAccent,

                          // focusedBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //     borderSide: BorderSide(
                          //         color: Colors.orangeAccent, width: 1))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8,
                      ),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        controller: pricecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You must enter the Price";
                          }
                        },
                        // initialValue: '0.00',
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Price",
                          labelText: "Price",

                          focusColor: Colors.orangeAccent,

                          // focusedBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //     borderSide: BorderSide(
                          //         color: Colors.orangeAccent, width: 1))
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10, right: 10),
                    //   child: Visibility(
                    //     child: InkWell(
                    //         child: Material(
                    //             borderRadius: BorderRadius.circular(12),
                    //             color: Colors.orangeAccent,
                    //             child: Padding(
                    //               padding: const EdgeInsets.only(left: 10, right: 10),
                    //               child: Row(
                    //                 children: [
                    //                   Expanded(
                    //                       child: Text(
                    //                     _currentCategory,
                    //                     style: TextStyle(color: Colors.white),
                    //                   )),
                    //                   IconButton(
                    //                       onPressed: () {
                    //                         setState(() {
                    //                           _currentCategory = '';
                    //                         });
                    //                       },
                    //                       icon: Icon(Icons.close))
                    //                 ],
                    //               ),
                    //             ))),
                    //     visible: _currentCategory != '',
                    //   ),
                    // ),
                    // TypeAheadField(
                    //   suggestionsCallback: (search) async {
                    //     List<String> suggestion =
                    //         await _categoryService.getSuggestion(search);
                    //     return suggestion;
                    //   },
                    //   builder: (context, controller, focusNode) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(left: 10, right: 10),
                    //       child: TextField(
                    //           controller: controller,
                    //           focusNode: focusNode,
                    //           autofocus: true,
                    //           decoration: InputDecoration(
                    //             labelText: 'Add category',
                    //           )),
                    //     );
                    //   },
                    //   itemBuilder: (context, suggestion) {
                    //     return ListTile(
                    //       title: Text(suggestion.toString()),
                    //       leading: Icon(Icons.category),
                    //     );
                    //   },
                    //   onSelected: (suggestion) {
                    //     print("Selected suggestion: $suggestion");
                    //     setState(() {
                    //       _currentCategory = suggestion.toString();
                    //     });
                    //     // Navigator.of(context).push<void>(
                    //     //   MaterialPageRoute(
                    //     //     builder: (context) => CityPage(city: city),
                    //     //   ),
                    //     // );
                    //   },
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10, right: 10),
                    //   child: Visibility(
                    //     visible: _currentBrand != '',
                    //     child: InkWell(
                    //       child: Material(
                    //         borderRadius: BorderRadius.circular(12),
                    //         color: Colors.orangeAccent,
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(left: 10, right: 10),
                    //           child: Row(
                    //             children: [
                    //               Expanded(
                    //                   child: Text(_currentBrand,
                    //                       style: TextStyle(color: Colors.white))),
                    //               IconButton(
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       _currentBrand = '';
                    //                     });
                    //                   },
                    //                   icon: Icon(Icons.close))
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // TypeAheadField(
                    //   suggestionsCallback: (search) async {
                    //     List<String> suggestion =
                    //         await _brandService.getSuggestion(search);
                    //     return suggestion;
                    //   },
                    //   builder: (context, controller, focusNode) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(left: 10, right: 10),
                    //       child: TextField(
                    //           controller: controller,
                    //           focusNode: focusNode,
                    //           autofocus: true,
                    //           decoration: InputDecoration(
                    //             labelText: 'Add brand',
                    //           )),
                    //     );
                    //   },
                    //   itemBuilder: (context, suggestion) {
                    //     return ListTile(
                    //       title: Text(suggestion.toString()),
                    //       leading: Icon(Icons.add_circle_outline),
                    //     );
                    //   },
                    //   onSelected: (suggestion) {
                    //     print("Selected suggestion: $suggestion");
                    //     setState(() {
                    //       _currentBrand = suggestion.toString();
                    //     });
                    //     // Navigator.of(context).push<void>(
                    //     //   MaterialPageRoute(
                    //     //     builder: (context) => CityPage(city: city),
                    //     //   ),
                    //     // );
                    //   },
                    // )
                    // // Center(
                    //   child: DropdownButton(
                    //     items: categoriesDropdown,
                    //     onChanged: changeSelectedCategories,
                    //     value: _currentCategory,
                    //   ),
                    // ),
                    // Expanded(
                    //     child: ListView.builder(
                    //         itemCount: categories.length,
                    //         itemBuilder: (context, index) {
                    //           return ListTile(
                    //             title: Text(categories[index]['category']),
                    //           );
                    //         }))
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                          onPressed: () {
                            validateAndUpdate();
                          },
                          child: Text(
                            "Add product",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  _getcategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      // print(data.length);
      categories = data;
      categoriesDropdown = getCategoriesDropdown();
      _currentCategory = categories[0].get('category');
      print('current category : ${_currentCategory}');
    });
  }

  _getbrand() async {
    List<DocumentSnapshot> data = await _brandService.getbrands();
    setState(() {
      // print(data.length);
      brands = data;
      brandsDropdown = getbrandDropdown();
      _currentBrand = brands[0].get('brand');
      print('current brand : ${_currentBrand}');
    });
  }

  void changeSelectedCategories(String? selectedCategories) {
    setState(() {
      _currentCategory = selectedCategories!;
    });
  }

  void changeSelectedBrand(String? selectedBrand) {
    setState(() {
      _currentBrand = selectedBrand!;
    });
  }

  void selectedImage(Future<XFile?> pickImage, int imageNumber) async {
    XFile? tempImage = await pickImage;
    if (tempImage != null) {
      File newImage = File(tempImage.path);

      switch (imageNumber) {
        case 1:
          setState(() {
            img1 = newImage;
          });
          break;
        case 2:
          setState(() {
            img2 = newImage;
          });
          break;
        case 3:
          setState(() {
            img3 = newImage;
          });
          break;
      }
    }
  }

  _displaychild1() {
    if (img1 == null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 25),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Image.file(
          img1!,
          // fit: BoxFit.cover,
        ),
      );
    }
  }

  _displaychild2() {
    if (img2 == null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 25),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Image.file(img2!));
    }
  }

  _displaychild3() {
    if (img3 == null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 25),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Image.file(
            img3!,
          ));
    }
  }

  void validateAndUpdate() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      if (img1 != null && img2 != null && img3 != null) {
        try {
          String imageurl1;
          String imageurl2;
          String imageurl3;
          final FirebaseStorage storage = FirebaseStorage.instance;
          final String pic1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          final task1 = storage.ref().child(pic1).putFile(img1!);
          final String pic2 =
              "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          final task2 = storage.ref().child(pic2).putFile(img2!);
          final String pic3 =
              "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          final task3 = storage.ref().child(pic3).putFile(img3!);
          TaskSnapshot snapshot1 =
              await task1.whenComplete(() {}).then((snapshot) => snapshot);
          TaskSnapshot snapshot2 =
              await task2.whenComplete(() {}).then((snapshot) => snapshot);
          task3.whenComplete(() {}).then((snapshot3) async {
            imageurl1 = await snapshot1.ref.getDownloadURL();
            imageurl2 = await snapshot2.ref.getDownloadURL();
            imageurl3 = await snapshot3.ref.getDownloadURL();
            List<String> imageList = [imageurl1, imageurl2, imageurl3];
            _productService.uploadProduct(
                productname: productcontroller.text.trim(),
                image: imageList,
                quantity: int.tryParse(quantitycontroller.text) ?? 0,
                price: double.tryParse(pricecontroller.text) ?? 0.0);
            log("product name : ${productcontroller.text}");
            productcontroller.clear();
            pricecontroller.clear();
            quantitycontroller.clear();
            img1 = null;
            img2 = null;
            img3 = null;

            // _formkey.currentState!.reset();
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                dismissDirection: DismissDirection.down,
                content: Text(
                  "Product added successfully!!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),

                backgroundColor: Colors.orangeAccent,
                behavior: SnackBarBehavior.floating,
                // margin: EdgeInsets.only(top: 70),
                duration: Duration(seconds: 2),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 100,
                  left: 10,
                  right: 10,
                ),
              ),
            );
          });
        } catch (e) {
          print('error');
        }
        // // setState(() {
        // // _formkey.currentState?.reset();
        // productcontroller.text = '';
        // img1 = null;
        // img2 = null;
        // img3 = null;
        // quantitycontroller.text = '';
        // pricecontroller.text = '';
        // // productcontroller.text = '';
        // // });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            dismissDirection: DismissDirection.down,
            content: Text(
              "All images must be provided!!",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: Colors.orangeAccent,
            behavior: SnackBarBehavior.floating,
            // margin: EdgeInsets.only(top: 70),
            duration: Duration(seconds: 2),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              left: 10,
              right: 10,
            ),
          ),
        );
      }
      // setState(() {
      // _formkey.currentState?.reset();
      // productcontroller.text = '';
      // img1 = null;
      // img2 = null;
      // img3 = null;
      // quantitycontroller.text = '';
      // pricecontroller.text = '';
      // productcontroller.text = '';
      // });
    }
  }
}
