import 'package:flutter/material.dart'; // Importa Flutter per utilitzar els widgets i altres components
import 'package:get/get.dart'; // Importa GetX per a la gestió d'estat i navegació
import 'package:supabase_flutter/supabase_flutter.dart'; // Importa Supabase per a la gestió de l'autenticació i la base de dades

class LoginController extends GetxController {
  RxBool isLoading = false.obs; // Variable observada per controlar l'estat de càrrega
  RxBool isHidden = true.obs; // Variable observada per controlar si la contrasenya és visible o no
  TextEditingController emailC = TextEditingController(); // Controlador per al camp de correu electrònic
  TextEditingController passwordC = TextEditingController(); // Controlador per al camp de contrasenya

  SupabaseClient client = Supabase.instance.client; // Client de Supabase per a interactuar amb la base de dades i l'autenticació

  // Funció per realitzar el login amb email i contrasenya
  Future<bool?> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) { // Comprovem que els camps no estiguin buits
      isLoading.value = true; // Iniciem l'estat de càrrega
      try {
        // Intentem fer login amb les credencials proporcionades
        await client.auth
            .signInWithPassword(email: emailC.text, password: passwordC.text);
        isLoading.value = false; // Aturem l'estat de càrrega
        // Mostrem un diàleg de confirmació si el login ha estat exitós
        Get.defaultDialog(
            barrierDismissible: false, // Impedim tancar el diàleg tocant fora
            title: "Login success", // Títol del diàleg
            middleText: "Will be redirect to Home Page", // Missatge del diàleg
            backgroundColor: Colors.green); // Color de fons verd per a un missatge positiu
        return true; // Retornem true per indicar que el login ha estat exitós
      } catch (e) {
        isLoading.value = false; // Aturem l'estat de càrrega en cas d'error
        Get.snackbar("ERROR", e.toString()); // Mostrem una snackbar amb l'error
      }
    } else {
      Get.snackbar("ERROR", "Email and password are required"); // Si algun camp està buit, mostrem un error
    }
    return null; // Retornem null en cas que el login no sigui exitós
  }
}
