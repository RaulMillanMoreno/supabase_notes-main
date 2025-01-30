import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX per a la gestió d'estat
import 'package:supabase_notes/app/routes/app_pages.dart'; // Importa les rutes de l'aplicació
import 'package:supabase_flutter/supabase_flutter.dart'; // Importa Supabase per a la gestió de la base de dades i l'autenticació

class ProfileController extends GetxController {
  // Variables per gestionar l'estat de la vista
  RxBool isLoading = false.obs; // Està en càrrega o no
  RxBool isHidden = true.obs; // Per amagar o mostrar la contrasenya
  TextEditingController nameC = TextEditingController(); // Controlador per al nom original
  TextEditingController nameC2 = TextEditingController(); // Controlador per a l'actualització del nom
  TextEditingController emailC = TextEditingController(); // Controlador per al correu electrònic
  TextEditingController passwordC = TextEditingController(); // Controlador per a la contrasenya

  // Instància del client de Supabase per interactuar amb la base de dades
  SupabaseClient client = Supabase.instance.client;

  // Mètode per tancar la sessió de l'usuari
  Future<void> logout() async {
    await client.auth.signOut(); // Tanca la sessió a Supabase
    Get.offAllNamed(Routes.LOGIN); // Redirigeix a la pàgina de login
  }

  // Mètode per obtenir el perfil de l'usuari des de la base de dades
  Future<void> getProfile() async {
    // Obté les dades de l'usuari a partir del UID (ID de l'usuari autenticat)
    List<dynamic> res = await client
        .from("users")
        .select()
        .match({"uid": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    
    // Omple els camps del formulari amb les dades de l'usuari
    nameC.text = user["name"];
    nameC2.text = user["name"];
    emailC.text = user["email"];
  }

  // Mètode per actualitzar les dades del perfil de l'usuari
  Future<void> updateProfile() async {
    if (nameC2.text.isNotEmpty) {
      isLoading.value = true; // Indica que s'està realitzant una operació

      // Actualitza el nom de l'usuari a la base de dades
      await client.from("users").update({
        "name": nameC2.text,
      }).match({"uid": client.auth.currentUser!.id});

      // Si l'usuari vol actualitzar la contrasenya
      if (passwordC.text.isNotEmpty) {
        if (passwordC.text.length >= 6) {
          try {
            // Actualitza la contrasenya a Supabase
            await client.auth.updateUser(UserAttributes(
              password: passwordC.text,
            ));
          } catch (e) {
            Get.snackbar("ERROR", e.toString()); // Mostra un missatge d'error si no es pot actualitzar
          }
        } else {
          Get.snackbar("ERROR", "Password must be longer than 6 characters");
        }
      }

      // Mostra un diàleg per informar que l'actualització s'ha completat
      Get.defaultDialog(
          barrierDismissible: false,
          title: "Update Profile success",
          middleText: "Name or Password will be updated",
          actions: [
            OutlinedButton(
                onPressed: () {
                  Get.back(); // Tanca el diàleg
                  Get.back(); // Torna a la pàgina de login
                },
                child: const Text("OK"))
          ]);

      isLoading.value = false; // Deixa d'estar en càrrega
    }
  }
}
