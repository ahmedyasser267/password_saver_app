import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app_v2/ui/widgets/input_field.dart';

import '../../controllers/address_control.dart';
import '../../models/address_model.dart';
import '../theme.dart';
import '../widgets/button.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final ContactController _contactController = Get.put(ContactController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Title
              InputField(
                title: 'Title',
                hint: 'Enter title here...',
                fieldController: _titleController,
              ),
              //Address
              InputField(
                title: 'Address',
                hint: 'Enter address here...',
                fieldController: _addressController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MyButton(
        label: 'Add Contact',
        onTap: _validateInput,
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Add Contact',
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

  void _validateInput() {
    if (_titleController.text.isNotEmpty &&
        _addressController.text.isNotEmpty) {
      _addContactToDb();
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

  void _addContactToDb() {
    _contactController.addContact(
      contact: Contact(
        id: null,
        name: _titleController.text,
        address: _addressController.text,
      ),
    );
  }
}
