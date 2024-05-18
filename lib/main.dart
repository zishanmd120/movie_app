import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_app_sheba_xyz/core/routes/app_pages.dart';
import 'package:movie_app_sheba_xyz/modules/home/binding/home_binding.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preferences;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  preferences.setString('access_token', 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjRlN2Q3NjBmY2E5ODQ1MmFmOWJkOGI5ZTdmNjgzZSIsInN1YiI6IjVmMGZmYjlmMjQ5NWFiMDAzNTM0MzkzNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MpxHC1ALg1zZ6EfGE5oJccWTrrJ2B8_D2J48dUu0GI4');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          backgroundColor: const Color(0xff131516),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white,),
          bodyMedium: TextStyle(color: Colors.white,),
          bodySmall: TextStyle(color: Colors.white,),
        ),
        useMaterial3: true,
      ),
      initialBinding: HomeBinding(),
      getPages: AppPages.pages,
      initialRoute: AppPages.INITIAL,
    );
  }
}


