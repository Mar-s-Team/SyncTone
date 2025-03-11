import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
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
  runApp(
    GetMaterialApp(
      title: 'SyncTone',
      initialRoute: supaProvider.client.auth.currentUser == null
          ? Routes.HOME
          : Routes.HOME,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        fontFamily: 'Cambria',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(186, 0, 0, 100),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      ),
    )
  );
}