import 'package:flutter/material.dart';
import 'package:to_do_app_v2/db/DB_login.dart';
import 'package:to_do_app_v2/ui/pages/Card_home.dart';

import 'maine.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
        Colors.blueGrey,
        Colors.blueAccent,
        Colors.blue,
        ],
    ),
    ),
    child: Column(children: <Widget>[
    const SizedBox(
    height: 60,
    ),
    Padding(
    padding: EdgeInsets.all(10),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const <Widget>[
    Text(
    "Sign Up",
    style: TextStyle(color: Colors.white, fontSize: 40),
    ),
    SizedBox(
    height: 10,
    ),
    Text(
    'Create an account',
    style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    ],
    ),
    ),
    const SizedBox(
    height: 20,
    ),
    Expanded(
    child: Container(
    decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(60),
    topRight: Radius.circular(60),
    ),
    ),
    child: ListView(children: <Widget>[
    const SizedBox(
    height: 40,
    ),
    Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
    BoxShadow(
    color: Colors.blueGrey,
    blurRadius: 5,
    offset: Offset(0, 5),
    ),
    ],
    ),
    child: Column(
    children: <Widget>[
    Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
    border: Border(
    bottom: BorderSide(
    color: Colors.blueGrey,
    ),
    ),
    ),
    child: TextField(
    controller: _nameController,
    decoration: InputDecoration(
    icon: Icon(
    Icons.person,
    color: Colors.blueGrey,
    ),
    hintText: "Name",
    hintStyle: TextStyle(color: Colors.grey),
    border: InputBorder.none,
    ),
    ),
    ),
    Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
    border: Border(
    bottom: BorderSide(
    color: Colors.blueGrey,
    ),
    ),
    ),
    child: TextField(
    controller: _emailController,
    decoration: InputDecoration(
    icon: Icon(
    Icons.email,
    color: Colors.blueGrey,
    ),
    hintText: "E-mail or phone number",
    hintStyle: TextStyle(color: Colors.grey),
    border: InputBorder.none,
    ),
    ),
    ),
    Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
    border: Border(
    bottom: BorderSide(
    color: Colors.blueGrey,
    ),
    ),
    ),
    child: TextField(
    controller: _passwordController,
    obscureText: true,
    decoration: InputDecoration(
    icon: Icon(
    Icons.lock,
    color: Colors.blueGrey,
    ),
    hintText: "Password",
    hintStyle:
    const TextStyle(color: Colors.grey),
    border: InputBorder.none,
    ),
    ),
    ),
    Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
    border: Border(
    bottom: BorderSide(
    color: Colors.blueGrey,
    ),
    ),
    ),
    child: TextField(
    controller: _confirmPasswordController,
    obscureText: true,
    decoration: InputDecoration(
    icon: Icon(
    Icons.lock,
    color: Colors.blueGrey,
    ),
    hintText: "Confirm Password",
    hintStyle:
    const TextStyle(color: Colors.grey),
    border: InputBorder.none,
    ),
    ),
    ),
    ],
    ),
    ),
    SizedBox(
    height: 40,
    ),
    Container(
    height: 50,
    margin: EdgeInsets.symmetric(horizontal: 50),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: Colors.blueGrey,
    ),
      child: InkWell(
        onTap: () async {
          String name = _nameController.text.trim();
          String email = _emailController.text.trim();
          String password = _passwordController.text.trim();
          String confirmPassword =
          _confirmPasswordController.text.trim();

          if (name.isEmpty ||
              email.isEmpty ||
              password.isEmpty ||
              confirmPassword.isEmpty) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Text("Please fill all fields."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          } else if (password != confirmPassword) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Text(
                    "Passwords do not match. Please try again."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          } else {
            User user = User(
              name: name,
              email: email,
              password: password,
            );
            DatabaseHelper databaseHelper =
                DatabaseHelper.instance;

            List<User> users =
            await databaseHelper.getUserList();

            bool isUserExist = false;
            for (int i = 0; i < users.length; i++) {
              if (users[i].email == email) {
                isUserExist = true;
                break;
              }
            }

            if (isUserExist) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Error"),
                  content: Text(
                      "This email already exists. Please use a different email."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            } else {
              await databaseHelper.insertUser(user);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Home()),
              );
            }
          }
        },
        borderRadius: BorderRadius.circular(50),
        child: const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
      SizedBox(
        height: 150,
      ),
    ]),
    ),
    ),
    ])));
  }
}