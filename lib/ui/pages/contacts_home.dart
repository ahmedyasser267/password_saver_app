import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_v2/models/task.dart';
import 'package:to_do_app_v2/services/notification_services.dart';
import 'package:to_do_app_v2/services/theme_services.dart';
import 'package:to_do_app_v2/ui/pages/add_Contact.dart';
import 'package:to_do_app_v2/ui/pages/add_task_page.dart';
import 'package:to_do_app_v2/ui/widgets/button.dart';
import 'package:to_do_app_v2/ui/widgets/task_tile.dart';

import '../../controllers/address_control.dart';
import '../../controllers/card control.dart';
import '../../controllers/task_controller.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/address_tile.dart';
import '../widgets/card_tile.dart';
import 'add_card.dart';

class ContactsHome extends StatefulWidget {
  const ContactsHome({Key? key}) : super(key: key);

  @override
  State<ContactsHome> createState() => ContactsHomeState();
}



class ContactsHomeState extends State<ContactsHome> {

  final ContactController _contactController = Get.put(ContactController());

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {

    _contactController.getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          /* _addTaskBar(),*/
          _addContactBar(),
          const SizedBox(height: 5.0),
          /* _showTasks()*/
          _showCo(),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor:
      Get.isDarkMode ? const Color(0x00303030) : Colors.white10,
      leading: IconButton(
        onPressed: () async {
          // NotifyHelper.showNotification(
          //     title: 'Theme Changed', body: 'switched theme', payload: '');
          ThemeServices().switchTheme();
        },
        icon: Icon(
          Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          size: 24,
          color: Colors.grey,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            _contactController.deleteAllContacts();
          },
          icon: const Icon(
            Icons.delete_forever,
            size: 35,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 10),
        const CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  //TaskBar
  Row _addTaskBar() {
    String time = DateFormat.yMMMMd().format(DateTime.now()).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //Date Time
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: subHeadingStyle),
            Text('Today', style: headingStyle),
          ],
        ),
        MyButton(
            label: '+ Add Task',
            onTap: () {
              Get.to(() => const AddTaskPage(),
                  transition: Transition.downToUp);
            })
      ],
    );
  }
  Row _addContactBar() {
    String time = DateFormat.yMMMMd().format(DateTime.now()).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //Date Time
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: subHeadingStyle),
            Text('Today', style: headingStyle),
          ],
        ),
        MyButton(
            label: '+ Add address',
            onTap: () {
              Get.to(() => const AddContactPage(),
                  transition: Transition.downToUp);
            })
      ],
    );
  }


  //Date Bar
  Container _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: 6,
        right: 3,
        left: 20.0,
      ),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        selectedTextColor: Colors.white,
        deactivatedColor: Colors.grey,
        selectionColor: primaryClr,
        initialSelectedDate: DateTime.now(),
        daysCount: 60,
        onDateChange: (newDate) {
          setState(() {
            selectedDate = newDate;
          });
        },
      ),
    );
  }

  //Tasks List
  _showTasks()
  {
    return Expanded(
      child: Obx(
            () => RefreshIndicator(
          onRefresh: () => _contactController.getContacts(),
          child: _contactController.contactsList.isEmpty
              ? _noTaskMsg()
              : ListView.builder(
              scrollDirection:
              SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemCount: _contactController.contactsList.length,
              itemBuilder: (context, index) {
                var task = _contactController.contactsList[index];

                if (task.repeat == 'Daily' ||
                    task.date == DateFormat.yMd().format(selectedDate) ||
                    (task.repeat == 'Weekly' &&
                        selectedDate
                            .difference(
                            DateFormat.yMd().parse(task.date))
                            .inDays %
                            7 ==
                            0) ||
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date).day ==
                            selectedDate.day)) {
                  var date = DateFormat.jm().parse(task.startTime);
                  var myTime = DateFormat('HH:mm').format(date);
                  print(myTime);
                  NotifyHelper.showScheduleNotification(
                      task: task,
                      hour: int.parse(myTime.toString().split(':')[0]),
                      minutes: int.parse(myTime.toString().split(':')[1]));

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1300),
                    child: SlideAnimation(
                      verticalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () => _showBottomSheet(context, task),
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                } else
                  return Container(height: 0);
              }),
        ),
      ),
    );
  }
  _showCo()
  {
    return Expanded(
      child: Obx(
            () => RefreshIndicator(
          onRefresh: () => _contactController.getContacts(),
          child: _contactController.contactsList.isEmpty
              ? _noTaskMsg()
              : ListView.builder(
              scrollDirection:
              SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemCount: _contactController.contactsList.length,
              itemBuilder: (context, index) {
                var con = _contactController.contactsList[index];


                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1300),
                  child: SlideAnimation(
                    verticalOffset: 300,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        child: ContactTile(con),
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }


  _noTaskMsg() {
    return ListView(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  height: SizeConfig.screenHeight * 0.7,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      SvgPicture.asset(
                        'images/task.svg',
                        height: 90,
                        semanticsLabel: 'Task',
                        color: primaryClr.withOpacity(0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Text(
                          "you don't have any address yet!\nTry to add new tasks and make your days productive",
                          style: subTitleStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1)
            ? SizeConfig.screenHeight * 0.6
            : SizeConfig.screenHeight * 0.8
            : (task.isCompleted == 1)
            ? SizeConfig.screenHeight * 0.30
            : SizeConfig.screenHeight * 0.5,
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [


            Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),

            const SizedBox(height: 20),
          ],
        ),
      ),
    ));
  }




}