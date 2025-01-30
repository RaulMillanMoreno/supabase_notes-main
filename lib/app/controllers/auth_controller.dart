import 'package:get/get.dart';
import 'package:supabase_notes/app/routes/app_pages.dart';
import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  // Temporitzador per gestionar la sessió de l'usuari
  Timer? authTimer;

  // Client de Supabase per gestionar l'autenticació
  SupabaseClient client = Supabase.instance.client;

  // Funció per configurar el tancament automàtic de sessió després d'1 hora
  Future<void> autoLogout() async {
    // Si ja hi ha un temporitzador actiu, es cancel·la per evitar múltiples instàncies
    if (authTimer != null) {
      authTimer!.cancel();
    }

    // Es configura un nou temporitzador que es dispararà després de 3600 segons (1 hora)
    authTimer = Timer(const Duration(seconds: 3600), () async {
      await client.auth.signOut(); // Es tanca la sessió de l'usuari
      Get.offAllNamed(Routes.LOGIN);
    }); 
  }

  // Funció per restablir el temporitzador (cancel·la el logout automàtic)
  Future<void> resetTimer() async {
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
  }
}