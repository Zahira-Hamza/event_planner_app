import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/widgets/event_date_time_widget.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/widgets/event_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Firebase-Firestore/firebase_utils.dart';
import '../../../../core/Firebase-Firestore/models/event.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_elavated button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class UpdateEventScreen extends StatefulWidget {
  const UpdateEventScreen({super.key});

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late Event event;
  DateTime? selectedDate;
  String formattedDate = '';
  String formattedTime = '';
  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      // Extract the event passed as an argument
      event = ModalRoute.of(context)!.settings.arguments as Event;

      // Pre-fill fields
      titleController.text = event.title;
      descriptionController.text = event.description;
      selectedDate = event.dateTime;
      formattedDate = DateFormat('d/M/yyyy').format(selectedDate!);
      formattedTime = event.time;

      isFirstTime = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Event".tr(),
          style: AppStyles.medium16blue.copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.bluePrimaryColor),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 1. Event Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    event.image,
                    fit: BoxFit.cover,
                    height: 210.h,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 16.h),

                /// 2. Title Field
                Text(
                  "Title".tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  textEditingController: titleController,
                  prefixIcon: const Icon(Icons.edit, color: Colors.grey),
                  hintText: "Event Title".tr(),
                  validator: Validators.validateFullName,
                ),
                SizedBox(height: 16.h),

                /// 3. Description Field
                Text(
                  "Description".tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  maxLines: 5,
                  textEditingController: descriptionController,
                  hintText: "Event Description".tr(),
                  validator: Validators.validateFullName,
                ),
                SizedBox(height: 16.h),

                /// 4. Date and Time Pickers
                EventDateTimeWidget(
                  calendar_clock_icon: AppAssets.calendar_icon,
                  event_date_time_text: "Event Date".tr(),
                  onPressed: chooseDate,
                  chooseDate_time_text: formattedDate,
                ),
                EventDateTimeWidget(
                  calendar_clock_icon: AppAssets.clock_icon,
                  event_date_time_text: "Event Time".tr(),
                  onPressed: chooseTime,
                  chooseDate_time_text: formattedTime,
                ),
                SizedBox(height: 16.h),

                /// 5. Replaced static Location with dynamic EventLocationWidget
                Text(
                  "Location".tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8.h),
                // Using the widget you provided to fetch the real address
                EventLocationWidget(lat: event.lat, long: event.long),

                SizedBox(height: 32.h),

                /// 6. Update Event Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: CustomElevatedButton(
                    onPressed: updateEventLogic,
                    buttonText: Text(
                      "Update Event".tr(),
                      style: AppStyles.bold20white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
        formattedDate = DateFormat('d/M/yyyy').format(selectedDate!);
      });
    }
  }

  void chooseTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        formattedTime = time.format(context);
      });
    }
  }

  void updateEventLogic() async {
    print("Update Button Pressed");

    if (formKey.currentState?.validate() == true) {
      // 1. Create the updated event object
      Event updatedEvent = Event(
        id: event.id,
        image: event.image,
        title: titleController.text,
        description: descriptionController.text,
        eventName: event.eventName,
        dateTime: selectedDate!,
        time: formattedTime,
        lat: event.lat,
        long: event.long,
        isFavorite: event.isFavorite,
      );

      try {
        print("Starting Firestore Update for ID: ${event.id}");

        // 2. Perform the Update with a timeout to prevent hanging
        await FirebaseUtils.getEventsCollection()
            .doc(event.id)
            .update(updatedEvent.toJson())
            .timeout(const Duration(seconds: 5));

        print("Update Successful in Firestore");

        // 3. Show Toast
        ToastUtils.showToast(message: "Event Updated Successfully".tr());

        // 4. Navigate to Home
        // If AppRoutes.homeRoute fails, this will catch it
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeRoute,
            (route) => false,
          );
        }
      } catch (error) {
        print("Detailed Error: $error");
        ToastUtils.showToast(message: "Update Failed".tr());
      }
    } else {
      print("Form Validation Failed");
    }
  }
}
