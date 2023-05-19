import 'package:flutter/material.dart';
import 'package:to_do_app_v2/models/card.dart';
import 'package:to_do_app_v2/ui/size_config.dart';
import 'package:to_do_app_v2/ui/theme.dart';

import '../../models/address_model.dart';

// ignore: must_be_immutable
class ContactTile extends StatelessWidget {
  ContactTile(this.address, {Key? key}) : super(key: key);

  final Contact address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 2
            : SizeConfig.screenWidth,
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(8)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: (Colors.teal)),
          child: Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.name ?? '',
                          style: titleStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            const SizedBox(width: 12),

                          ],
                        ),
                        Text(
                          'password ${address.address}' ?? '',
                          style: titleStyle.copyWith(
                            color: Colors.grey[100],
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 0.5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBGClr(int? color) {
    switch (color) {
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;

      default:
        return bluishClr;
    }
  }
}
