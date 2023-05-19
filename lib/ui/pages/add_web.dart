import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app_v2/ui/widgets/input_field.dart';

import '../../controllers/address_control.dart';
import '../../controllers/web_controll.dart';
import '../../models/address_model.dart';
import '../../models/web.dart';
import '../theme.dart';
import '../widgets/button.dart';

class AddWebPage extends StatefulWidget {
  const AddWebPage({Key? key}) : super(key: key);

  @override
  State<AddWebPage> createState() => _AddWebPageState();
}

class _AddWebPageState extends State<AddWebPage> {
 // final ContactController _contactController = Get.put(ContactController());
  final  WebController _webController = Get.put(WebController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
              InputField(
                title: 'name web',
                hint: 'Enter title here...',
                fieldController: _nameController,
              ),
              InputField(
                title: 'Email',
                hint: 'Enter email here...',
                fieldController: _emailController,
              ),
              InputField(
                title: 'password',
                hint: 'Enter password here...',
                fieldController: _passwordController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: MyButton(
        label: 'Add Website',
        onTap: _validateInput,
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Add Website',
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
    if (_nameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty&&_emailController.text.isNotEmpty) {
      _addWebToDb();
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

  void _addWebToDb() {
    _webController.addWeb(
      web: Web(
        id: null,
        name: _nameController.text,
        email: _emailController.text,
        password:_passwordController.text,
      ),
    );
  }
}
