import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:synctone/controllers/bottom_navigator_controller.dart';
import 'package:synctone/routes/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  String supaUri = dotenv.get('SUPABASE_URL');
  String supaAnon = dotenv.get('SUPABASE_ANON_KEY');

  Supabase supaProvider = await Supabase.initialize(
    url: supaUri,
    anonKey: supaAnon,
  );
  final authC = Get.put(BottomNavigatorController(), permanent: true);

  runApp(
    GetMaterialApp(
      title: 'SyncTone',
      initialRoute: supaProvider.client.auth.currentUser == null
          ? Routes.HOME //TODO auth login
          : Routes.HOME,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Color.fromRGBO(r, g, b, opacity),
        //
        // ),
        scaffoldBackgroundColor: const Color(0xFF2B2B2B),
        fontFamily: 'Cambria',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2B2B2B),
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF8400C4)
        ),
      ),
    )
  );
}