// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Per carregar variables d'entorn
import 'package:get/get.dart'; // Per a la gestió d'estats i rutes amb GetX
import 'package:supabase_notes/app/controllers/auth_controller.dart'; // Per gestionar l'autenticació
import 'package:supabase_flutter/supabase_flutter.dart'; // Per integrar amb Supabase

import 'app/routes/app_pages.dart'; // Per a la definició de les rutes de l'aplicació

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Assegura que les inicialitzacions es facin correctament
  await dotenv.load(); // Espera a que les variables d'entorn es carreguin

  String supaUri = dotenv.get('SUPABASE_URL'); // Obtén la URL de Supabase des de les variables d'entorn
  String supaAnon = dotenv.get('SUPABASE_ANONKEY'); // Obtén la clau anònima de Supabase

  Supabase supaProvider = await Supabase.initialize( // Inicialitza la connexió a Supabase
    url: supaUri, // URL de Supabase
    anonKey: supaAnon, // Clau anònima de Supabase
  );

  final authC = Get.put(AuthController(), permanent: true); // Col·loca el controlador d'autenticació de GetX

  // Inicia l'aplicació Flutter
  runApp(
    GetMaterialApp(
      title: "Pel·lícules App", // Nom de l'aplicació (pots canviar-lo per alguna cosa més rellevant)
      initialRoute: supaProvider.client.auth.currentUser == null // Verifica si l'usuari està loguejat
          ? Routes.LOGIN // Si l'usuari no està loguejat, obre la vista de LOGIN
          : Routes.HOME, // Si l'usuari ja està loguejat, obre la vista HOME
      getPages: AppPages.routes, // Configura les rutes definides a app_pages.dart
      debugShowCheckedModeBanner: false, // Desactiva la bandera de depuració (banner de "debug")
    ),
  );
}
