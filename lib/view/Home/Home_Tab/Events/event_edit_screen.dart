import 'package:easy_localization/easy_localization.dart';
import 'package:event_planner_app/view/Home/Home_Tab/Events/widgets/event_date_time_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_elavated button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/event_category_tab_item.dart';

///create event screen
class EventEditScreen extends StatefulWidget {
  EventEditScreen({super.key});

  @override
  State<EventEditScreen> createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  int selectedIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  String formattedDate = '';
  TimeOfDay? selectedTime;
  String formattedTime = '';

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    List<String> eventsName = [
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
    List<String> eventsImage = [
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Edit Event".tr(), style: AppStyles.medium16blue),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.bluePrimaryColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.04,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///////////////////event image/////////////////////////////////
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(eventsImage[selectedIndex]),
              ),
              SizedBox(height: screenHeight * 0.02),
              ////////////////tabs using listView and the custom widget event_tab_item////////////////////////////
              SizedBox(
                height: screenHeight * 0.077,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventsName.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                        setState(() {});
                      },
                      child: EventCategoryTabItem(
                        selectedBgColor: AppColors.bluePrimaryColor,
                        isSelected: selectedIndex == index,
                        event: eventsName[index],
                        borderColor: AppColors.bluePrimaryColor,
                        selectedTextStyle: Theme.of(
                          context,
                        ).textTheme.displayMedium!,
                        unselectedTextStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.bluePrimaryColor),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: screenWidth * .001);
                  },
                ),
              ),
              ////// /////title text_form_field//////////////////////
              SizedBox(height: screenHeight * 0.02),
              Text("Title".tr(), style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: screenHeight * 0.01),
              CustomTextFormField(
                textEditingController: titleController,
                prefixIcon: Image.asset(
                  AppAssets.edit_icon,
                  color: Theme.of(context).disabledColor,
                ),
                hintText: " We Are Going To Play Football".tr(),
                hintStyle: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: screenHeight * 0.02),

              ///////////////////description text_form_field/////////////////////////////////
              Text(
                "Description".tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextFormField(
                //todo:controller
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textEditingController: descriptionController,

                hintText:
                    " Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.",
                hintStyle: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: screenHeight * 0.02),
              //////////////////////////////////////////////////////////////////////////////////////////
              EventDateTimeWidget(
                calendar_clock_icon: AppAssets.calendar_icon,
                event_date_time_text: "Event Date".tr(),
                onPressed: chooseDate, //Reference to chooseDate_time function
                chooseDate_time_text: selectedDate == null
                    ? "30/11/2024".tr()
                    : formattedDate,
              ),
              EventDateTimeWidget(
                calendar_clock_icon: AppAssets.clock_icon,
                event_date_time_text: "Event Time".tr(),
                onPressed: chooseTime, //Reference to chooseDate_time function
                chooseDate_time_text: selectedTime == null
                    ? "11:22".tr()
                    : formattedTime,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Location".tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: screenHeight * 0.01),
              //////////////////////////////////////////////////////////////////////////////
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.bluePrimaryColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.02,
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppAssets.chooseEvent_icon),
                      SizedBox(width: screenWidth * 0.02),
                      Text("Cairo , Egypt".tr(), style: AppStyles.medium16blue),
                      Spacer(),
                      Icon(
                        Icons.navigate_next,
                        color: AppColors.bluePrimaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: screenHeight * 0.1),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomElevatedButton(
                      onPressed: updateEvent,
                      buttonText: Text(
                        "Update Event".tr(),
                        style: AppStyles.bold20white.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ////////////choosing date and time functions manually(we can use a package but note to support localization)///////////////////////
  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    formattedDate = DateFormat(' d/M/yyyy').format(selectedDate!);
    setState(() {});
  }

  void chooseTime() async {
    //todo: show date picker
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    formattedTime = selectedTime!.format(context);
    setState(() {});
  }

  void updateEvent() {
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Event updated successfully!".tr())));
  }
}
