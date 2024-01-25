// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:todo_list_app/util/DateFormat.dart';
import 'package:todo_list_app/widgets/background.dart';

class StateModel {
  const StateModel(this.name, this.code);
  final String code;
  final String name;

  @override
  String toString() => name;
}

enum DateTimeInputType { start, finish }

const List<StateModel> remindOptions = <StateModel>[
  StateModel('Before 15 minutes', '0'),
  StateModel('Before 10 minutes', '1'),
  StateModel('Before 5 minutes', '2'),
  StateModel('At the start time', '3'),
  StateModel('After 5 minutes', '4'),
  StateModel('After 10 minutes', '5'),
  StateModel('After 15 minutes', '6'),
];

class CreateSchedulePage extends StatefulWidget {
  const CreateSchedulePage({super.key});

  @override
  State<CreateSchedulePage> createState() => _CreateSchedulePageState();
}

class _CreateSchedulePageState extends State<CreateSchedulePage> {
  late Size screenSize;
  DateTime startDate = DateTime.now();
  DateTime finishDate = DateTime.now().add(Duration(hours: 1));
  DateTime? lastSelectedDate;
  StateModel selectedRemindOption = remindOptions[0];

  final _titleController = TextEditingController();
  final _placeController = TextEditingController();
  final _noteController = TextEditingController();

  bool isScheduleCreating = false;

  @override
  void dispose() {
    _titleController.dispose();
    _placeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void createNewSchedule() async {
    setState(() => isScheduleCreating = true);

    await Future.delayed(Duration(seconds: 1));

    AnimatedSnackBar.material(
      'Schedule created!',
      type: AnimatedSnackBarType.success,
    ).show(context);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: SizedBox(
            width: screenSize.width,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Wrap(
                  runSpacing: 20,
                  children: [
                    buildNavigationButtons(),
                    SizedBox(height: 26),
                    SizedBox(height: 15),
                    buildInputField(_titleController, "Schedule title"),
                    buildDateTimeInput(
                        DateTimeInputType.start, "Date", startDate),
                    buildDateTimeInput(
                        DateTimeInputType.finish, "Finish", finishDate),
                    // buildRepeatSelection(),
                    buildRemindSelection(),
                    buildInputField(_placeController, "Place"),
                    buildInputField(_noteController, "Note",
                        height: screenSize.height * 0.4),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildRemindSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Remind",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: openRemindSelectMenu,
          child: SizedBox(
            child: Row(
              children: [
                Text(
                  selectedRemindOption.name,
                  style: TextStyle(
                    color: Color(0xff828282),
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff828282),
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Todo: Açılan ekranda istenen tarih seçildikten sonra, kullanıcı onaylama butonuna basacak
  // todo: ardından uygulama verilen tarihi kaydedecek
  // todo: start ve finish bölümlerini buildleyen fonksiyonlara hangi date'i kontrol ettiklerine dair parametre eklenmeli

  void openRemindSelectMenu() {
    showMaterialScrollPicker<StateModel>(
      context: context,
      title: 'Remind me',
      items: remindOptions,
      selectedItem: selectedRemindOption,
      onChanged: (value) => setState(() => selectedRemindOption = value),
      showDivider: false,
    );
  }

  Widget buildDateTimeInput(
      DateTimeInputType dateInputType, String title, DateTime targetDateTime) {
    return GestureDetector(
      onTap: () => {
        DatePicker.showDatePicker(
          context,
          pickerTheme: DateTimePickerTheme(
            showTitle: true,
            backgroundColor: Color(0xff8c7ae6),
            itemTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            title: Container(
              width: 2460,
              height: 35,
              color: Color(0xff8c7ae6),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.pop(context),
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    Text(
                      "Select start a date",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: dateInputType == DateTimeInputType.start
                          ? setStartDate
                          : setFinishDate,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          dateFormat: 'dd MMMM yyyy HH:mm',
          initialDateTime: DateTime.now(),
          minDateTime: DateTime.now(),
          maxDateTime: DateTime.now().add(Duration(days: 365 * 5)),
          onMonthChangeStartWithFirstDate: false,
          onChange: (dateTime, selectedIndex) {
            lastSelectedDate = dateTime;
          },
        ),
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              Text(
                DateFormat.convertToCustomFormat(targetDateTime),
                style: TextStyle(
                  color: Color(0xff828282),
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff828282),
                size: 16,
              )
            ],
          ),
        ],
      ),
    );
  }

  void setStartDate() {
    if (lastSelectedDate == null) {
      return;
    }

    setState(() {
      startDate = lastSelectedDate!.copyWith();
      if (finishDate.isBefore(startDate)) {
        finishDate = startDate.add(Duration(hours: 1));
      }
    });

    closeDateInputMenu();
  }

  void setFinishDate() {
    if (lastSelectedDate == null) {
      return;
    }

    setState(() {
      finishDate = lastSelectedDate!.copyWith();
    });

    closeDateInputMenu();
  }

  void closeDateInputMenu() {
    Navigator.pop(context);
  }

  Container buildInputField(TextEditingController controller, String title,
      {double height = 40}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Color(0xffCCC2FE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: controller,
        maxLines: 50,
        style: TextStyle(overflow: TextOverflow.ellipsis),
        decoration: InputDecoration(
          hintText: title,
          contentPadding: EdgeInsets.only(left: 6, top: 4),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Row buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        Text(
          "Create new a Schedule",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: isScheduleCreating == false ? createNewSchedule : null,
          child: isScheduleCreating == false
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                )
              : SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }

  Widget buildRepeatSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Repeat",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Row(
          children: [
            Text(
              "Never",
              style: TextStyle(
                color: Color(0xff828282),
                fontSize: 16,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff828282),
              size: 16,
            )
          ],
        ),
      ],
    );
  }
}
