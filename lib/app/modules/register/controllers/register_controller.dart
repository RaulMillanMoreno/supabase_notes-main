import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  // Estats reactius per controlar el càrrec i la visibilitat de la contrasenya
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;

  // Controladors per als camps de text de nom, correu electrònic i contrasenya
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  // Client de Supabase per interactuar amb l'autenticació i la base de dades
  SupabaseClient client = Supabase.instance.client;

  // Mètode per registrar un usuari nou
  Future<void> signUp() async {
    // Comprovem si tots els camps estan omplerts
    if (emailC.text.isNotEmpty &&
        passwordC.text.isNotEmpty &&
        nameC.text.isNotEmpty) {
      isLoading.value = true; // Iniciem l'estat de càrrega
      try {
        // Intentem registrar l'usuari amb la seva adreça de correu i contrasenya
        AuthResponse res = await client.auth
            .signUp(password: passwordC.text, email: emailC.text);
        isLoading.value = false;

        // Si el registre és exitós, afegim l'usuari a la taula 'users'
        await client.from("users").insert({
          "name": nameC.text,
          "email": emailC.text,
          "created_at": DateTime.now().toIso8601String(),
          "uid": res.user!.id, // Afegeix l'uid de l'usuari de Supabase
        });

        // Mostrem un diàleg d'èxit amb un missatge per confirmar el correu electrònic
        Get.defaultDialog(
            barrierDismissible: false,
            title: "Registration success",
            middleText: "Please confirm email: ${res.user!.email}",
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Get.back(); // Tanquem el diàleg
                    Get.back(); // Tornem a la vista de login
                  },
                  child: const Text("OK"))
            ]);
      } catch (e) {
        isLoading.value = false; // Aturem l'estat de càrrega en cas d'error
        Get.snackbar("ERROR", e.toString()); // Mostrem un missatge d'error
      }
    } else {
      // Si algun dels camps no està omplert, mostrem un missatge d'error
      Get.snackbar("ERROR", "Email, password and name are required");
    }
  }
}
