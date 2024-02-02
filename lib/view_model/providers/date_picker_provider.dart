import 'package:flutter/material.dart';
import 'package:Deva_Tracking/view_model/utils/colors.dart';

class DatePickerProvider extends ChangeNotifier {
  // int? daysDifference;
  DateTime? currentDateTime = DateTime.now();

  void changeDate(DateTime dateTime) {
    currentDateTime = dateTime;
    notifyListeners();
  }

  Future<DateTime> mainPicker(
    context, {
    bool isAppointment = false,
    DateTime? pickDateTime,
    bool pickDate = true,
    showPreviousDate = false,
  }) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: pickDate ? DateTime.now() : pickDateTime ?? DateTime.now(),
        firstDate: showPreviousDate
            ? DateTime(DateTime.now().year - 100)
            : DateTime.now(),
        lastDate: isAppointment
            ? DateTime(2100)
            : (pickDate ? DateTime.now() : pickDateTime ?? DateTime.now()),
        builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: AppColor.primary),
            ),
            child: child!),
        initialEntryMode: DatePickerEntryMode.calendar);

    return pickedDate ?? DateTime.now();
  }

  int calculateTimeDifference({required DateTime futurePickedDate}) {
    DateTime currentDate = DateTime.now();
    DateTime futureDate = futurePickedDate;
    Duration difference = futureDate.difference(currentDate);

    int daysDifference = difference.inDays;
    notifyListeners();
    return daysDifference;
  }
}
