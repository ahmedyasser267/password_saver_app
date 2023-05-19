import 'package:get/get.dart';
import 'package:to_do_app_v2/db/card_db.dart';
import 'package:to_do_app_v2/db/db_helper.dart';
import 'package:to_do_app_v2/models/card.dart';

class CardController extends GetxController {
  RxList cardList = <MyCard>[].obs;
  DBHelperc dbHelper = DBHelperc();

  Future<void> getCards() async {
    final cards = await dbHelper.queryCards();

    cardList.assignAll(cards.map((e) => MyCard.fromMap(e)).toList());

    update();
  }

  Future<void>  addCard({required MyCard? card}) async {
    await dbHelper.insertCard(card);
    getCards();
  }

  void deleteCard({required MyCard card}) async {
    await dbHelper.deleteCard(card.id!);
    getCards();
  }

  void updateCard({required MyCard card}) async {
    await dbHelper.updateCard(card);
    getCards();
  }

  void deleteAllCards() async {
    await dbHelper.deleteAllCards();
    cardList.clear();
    update();
  }
}
