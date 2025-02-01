import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart'; 

class LoginController extends GetxController {
  RxBool isLoading = false.obs; 
  RxBool isHidden = true.obs; 
  TextEditingController emailC = TextEditingController(); 
  TextEditingController passwordC = TextEditingController();

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
            title: "Login success",
            middleText: "Will be redirect to Home Page", 
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
