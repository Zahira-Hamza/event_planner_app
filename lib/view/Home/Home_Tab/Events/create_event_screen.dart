import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/widgets/event_date_time_widget.dart';
import 'package:event_planner_app/view/Home/Home_Tab/widgets/event_category_tab_item.dart';
import 'package:event_planner_app/view_model/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/Firebase-Firestore/firebase_auth_utils.dart';
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

// Assuming these paths based on your previous messages

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedImage = "";
  String? selectedEventName = "";
  DateTime? selectedDate;
  String formattedDate = '';
  TimeOfDay? selectedTime;
  String formattedTime = '';
  final formKey = GlobalKey<FormState>();
  late AppProvider appProvider;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // Local logic for images and names
    final List<String> eventsName = [
      'Sport'.tr(),
      'Birthday'.tr(),
      'Meeting'.tr(),
      'Gaming'.tr(),
      'WorkShop'.tr(),
      'BookClub'.tr(),
      'Exhibition'.tr(),
      'Holiday'.tr(),
      'Eating'.tr(),
    ];
    final List<String> eventsImage = [
      AppAssets.sport_image,
      AppAssets.birthday_image,
      AppAssets.meeting_image,
      AppAssets.gaming_image,
      AppAssets.workShop_image,
      AppAssets.bookClub_image,
      AppAssets.exhibition_image,
      AppAssets.holiday_image,
      AppAssets.eating_image,
    ];
    selectedImage = eventsImage[selectedIndex];
    selectedEventName = eventsName[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Create Event".tr(),
          style: AppStyles.medium16blue.copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.bluePrimaryColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Event Image Header
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Image.asset(
                    AppAssets.getEventImage(
                      context,
                      eventsImage[selectedIndex],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.h),

                /// Category Selection Tabs
                SizedBox(
                  height: 50.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventsName.length,
                    separatorBuilder: (context, index) => SizedBox(width: 3.w),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => setState(() => selectedIndex = index),
                        child: EventCategoryTabItem(
                          selectedBgColor: AppColors.bluePrimaryColor,
                          isSelected: selectedIndex == index,
                          event: eventsName[index],
                          borderColor: AppColors.bluePrimaryColor,
                          selectedTextStyle: AppStyles.medium16white,
                          unselectedTextStyle: AppStyles.medium16blue,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),

                /// Title Field
                Text(
                  "Title".tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  textEditingController: titleController,
                  prefixIcon: const Icon(Icons.edit, color: Colors.grey),
                  hintText: "Event Title".tr(),
                  validator: Validators
                      .validateFullName, // Using your custom validator
                ),
                SizedBox(height: 16.h),

                /// Description Field
                Text(
                  "Description".tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  maxLines: 8,
                  textEditingController: descriptionController,
                  hintText: "Event Description".tr(),
                  validator: Validators.validateFullName,
                ),
                SizedBox(height: 16.h),

                /// Date and Time Pickers
                EventDateTimeWidget(
                  calendar_clock_icon: AppAssets.calendar_icon,
                  event_date_time_text: "Event Date".tr(),
                  onPressed: chooseDate,
                  chooseDate_time_text: selectedDate == null
                      ? "Choose Date".tr()
                      : formattedDate,
                ),
                EventDateTimeWidget(
                  calendar_clock_icon: AppAssets.clock_icon,
                  event_date_time_text: "Event Time".tr(),
                  onPressed: chooseTime,
                  chooseDate_time_text: selectedTime == null
                      ? "Choose Time".tr()
                      : formattedTime,
                ),
                SizedBox(height: 16.h),

                /// Location Placeholder
                Text(
                  "Location".tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.pickEventLocationRoute,
                    );
                  },
                  child: Consumer<AppProvider>(
                    builder: (context, provider, child) => Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.bluePrimaryColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: AppColors.bluePrimaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.gps_fixed,
                              color: Colors.white,
                              size: 24.r,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: Text(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              appProvider.eventLocation == null
                                  ? "Choose Event Location".tr()
                                  : (appProvider.eventAddress ??
                                        "Fetching address..."), // Show address here
                              style: AppStyles.medium16blue,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.navigate_next,
                            color: AppColors.bluePrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),

                /// Add Event Button
                Container(
                  width: double.infinity,
                  height: 56.h,
                  child: CustomElevatedButton(
                    onPressed: addEvent,
                    buttonText: Text(
                      "Add Event".tr(),
                      style: AppStyles.bold20white.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
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
      initialDate: DateTime.now(),
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
        selectedTime = time;
        formattedTime = selectedTime!.format(context);
      });
    }
  }

  void addEvent() async {
    if (appProvider.eventLocation == null) {
      ToastUtils.showToast(message: "Please select event location".tr());
      return;
    }

    if (formKey.currentState?.validate() == true) {
      if (selectedDate == null || selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select date and time".tr())),
        );
        return;
      }

      // 1. Get current logged-in user ID
      String currentUserId = FirebaseAuthUtils.getCurrentUser()?.uid ?? "";

      // 2. Create event with the userId
      Event event = Event(
        image: selectedImage!,
        title: titleController.text,
        description: descriptionController.text,
        eventName: selectedEventName!,
        dateTime: selectedDate!,
        time: formattedTime,
        lat: appProvider.eventLocation?.latitude ?? 0,
        long: appProvider.eventLocation?.longitude ?? 0,
        userId: currentUserId, // Implementation: Add the UID here
      );

      try {
        // 3. Wait for Firestore to finish (removed the 500ms timeout)
        await FirebaseUtils.addEventToFireStore(event);

        ToastUtils.showToast(message: "Event Added Successfully".tr());
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        // This will now show you more specific error details if permission fails
        debugPrint("Firestore Error: $e");
        ToastUtils.showToast(message: "Error: $e");
      }
    }
  }
}
