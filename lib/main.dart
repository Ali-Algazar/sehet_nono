import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(SehetNonoApp());
}

class SehetNonoApp extends StatelessWidget {
  const SehetNonoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>
          MaterialApp(debugShowCheckedModeBanner: false),
    );
  }
}
