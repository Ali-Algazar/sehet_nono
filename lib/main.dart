import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sehet_nono/core/helper/hive_helper.dart';
import 'package:sehet_nono/core/helper_functions/on_generate_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveHelper.init();

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
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
