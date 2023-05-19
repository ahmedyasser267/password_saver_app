import 'package:get/get.dart';
import 'package:to_do_app_v2/db/db_helper.dart';

import '../db/address_dp.dart';
import '../db/web_dp.dart';
import '../models/address_model.dart';
import '../models/web.dart';

class WebController extends GetxController {
  RxList websList = <Web>[].obs;
  DBHelperc3 dbHelper = DBHelperc3();

  Future<void> getWebs() async {
    final webs = await dbHelper.queryWeb();

    websList.assignAll(webs.map((e) => Web.fromMap(e)).toList());

    update();
  }

  Future<void> addWeb({required Web? web}) async {
    await dbHelper.insertWeb(web);
    getWebs();
  }

  void deleteWeb({required Web webs}) async {
    await dbHelper.deleteWeb(webs.id!);
    getWebs();
  }

  void updateWeb({required Web web}) async {
    await dbHelper.updateWeb(web);
    getWebs();
  }

  void deleteAllWeb() async {
    await dbHelper.deleteAllWeb();
    websList.clear();
    update();
  }
}
