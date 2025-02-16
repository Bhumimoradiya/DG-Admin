import 'package:dg_admin/screens/homepage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var size, height, width;
  bool isvisible = false;
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var email = "";
  var password = "";
  final _formkey = GlobalKey<FormState>();
  void updateStatus() {
    setState(() {
      isvisible = !isvisible;
    });
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        body: Form(
      key: _formkey,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.72), BlendMode.dstATop),
                image: AssetImage(
                  "assets/images/pillow-light-indoor-modern-room 1.png",
                ),
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat,
                opacity: 500)),
        child: SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: height * 0.05,
                height: 40,
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Homepage()));
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 110, left: 25),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25),
                child: Text(
                  "Welcome back! Please login to your\naccount.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 25),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(fontWeight: FontWeight.w500),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            // width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      hintText: "Enter your email",
                      prefixIcon: Icon(
                        Icons.mail_rounded,
                        color: Colors.white,
                        size: 22,
                      )),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*Email cannot be empty";
                    } else if (!value.contains('@')) {
                      return "You have entered an invalid e-mail address.\nPlease try again.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(fontWeight: FontWeight.w500),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            // width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      hintText: "Enter your password",
                      suffixIcon: IconButton(
                        onPressed: () => updateStatus(),
                        icon: Icon(
                          isvisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 22,
                      )),
                  obscureText: isvisible ? false : true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  validator: (Value) {
                    if (Value!.isEmpty) {
                      return "*Password cannot be empty.";
                    } else if (Value.length < 6) {
                      return "Password length should be at least 6 characters\nlong.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.black,
                          fillColor: MaterialStateColor.resolveWith(getColor),
                          value: isChecked,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text(
                          "Remember Me",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, right: 10),
                      child: TextButton(
                          style: ButtonStyle(
                              overlayColor:
                                  MaterialStatePropertyAll(Colors.transparent)),
                          onPressed: () {
                            //   Navigator.push(context,
                            // MaterialPageRoute(builder: (_) => Homepage()));
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // height: height * 0.1,
                height: 70,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)), backgroundColor: Colors.orangeAccent,
                          minimumSize: Size(300, 55)),
                      onPressed: () {
                        // Login(emailController.text.toString(),
                        //     passwordController.text.toString());
                        if (_formkey.currentState!.validate()) {
                          if (email == "moradiyabhumi55@gmail.com" &&
                              password == "Bhumi#@119") {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Homepage()));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                // padding: EdgeInsets.only(top: 150),
                                margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 150,
                                  left: 10,
                                  right: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Colors.green,
                                elevation: 10,
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text('Login Successfully!!'),
                                  ],
                                )));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 100,
                                  left: 10,
                                  right: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Text(
                                            "Email or Password are wrong!!\nPlease try again"),
                                      ],
                                    ),
                                  ],
                                )));
                          }
                          // setState(() {
                          //   email = emailController.text;
                          //   password = passwordController.text;
                          // });
                          // nextscreen(context, Homepage());
                          // signInWithEmailAndPassword();
                        }
                      },
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text.rich(TextSpan(
                    text: "New User? ",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: "Signup",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //   Navigator.push(context,
                            // MaterialPageRoute(builder: (_) => Homepage()));
                          },
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
