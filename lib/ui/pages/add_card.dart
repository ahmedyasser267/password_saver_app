import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app_v2/models/card.dart';
import 'package:to_do_app_v2/ui/widgets/input_field.dart';

import '../../controllers/card control.dart';
import '../theme.dart';
import '../widgets/button.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final CardController _cardController = Get.put(CardController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Name
              InputField(
                title: 'Name',
                hint: 'Enter your name here...',
                fieldController: _nameController,
              ),
              //Card Number
              InputField(
                title: 'Card Number',
                hint: 'Enter your card number here...',
                fieldController: _cardNumberController,
              ),
              //PIN
              InputField(
                title: 'PIN',
                hint: 'Enter your PIN here...',
                fieldController: _pinController,
              ),
              //Password
              InputField(
                title: 'Password',
                hint: 'Enter your password here...',
                fieldController: _passwordController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MyButton(
        label: 'Add Card',
        onTap: () {
          _validateInput();
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Add Card',
        style: headingStyle,
      ),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: Colors.grey,
        ),
      ),
    );
  }

  _validateInput() {
    if (_nameController.text.isNotEmpty &&
        _cardNumberController.text.isNotEmpty &&
        _pinController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _addCardToDb();
      Get.back();
    } else {
      Get.snackbar(
        'Required',
        'All fields are required',
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        colorText: pinkClr,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }

  _addCardToDb() {
    _cardController.addCard(
      card: MyCard(
        id: null,
        name: _nameController.text,
        cardNumber: _cardNumberController.text,
        pin: _pinController.text,
        password: _passwordController.text,
      ),
    );
  }
}
