import 'package:get/get.dart';
import 'package:to_do_app_v2/db/db_helper.dart';

import '../db/address_dp.dart';
import '../models/address_model.dart';

class ContactController extends GetxController {
  RxList contactsList = <Contact>[].obs;
  DBHelperc2 dbHelper = DBHelperc2();

  Future<void> getContacts() async {
    final contacts = await dbHelper.queryContacts();

    contactsList.assignAll(contacts.map((e) => Contact.fromMap(e)).toList());

    update();
  }

  Future<void> addContact({required Contact? contact}) async {
    await dbHelper.insertContact(contact);
    getContacts();
  }

  void deleteContact({required Contact contact}) async {
    await dbHelper.deleteContact(contact.id!);
    getContacts();
  }

  void updateContact({required Contact contact}) async {
    await dbHelper.updateContact(contact);
    getContacts();
  }

  void deleteAllContacts() async {
    await dbHelper.deleteAllContacts();
    contactsList.clear();
    update();
  }
}
