import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  //google fonts
  static final TextStyle bold20blue = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.bluePrimaryColor,
  );

  static final TextStyle medium16black = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.blackPrimaryColor,
  );
  static final TextStyle medium16gray = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
  static final TextStyle medium16blue = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.bluePrimaryColor,
  );
  static final TextStyle medium16white = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whitePrimaryColor,
  );

  static final TextStyle bold20black = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Color(0xff1C1C1C),
  );
  static final TextStyle bold20white = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static final TextStyle bold12white = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
