import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNoteController extends GetxController {
  // Estat per gestionar la càrrega mentre s'afegeix una pel·lícula
  RxBool isLoading = false.obs;

  // Controladors dels camps de text per introduir la informació de la pel·lícula
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController minAgeC = TextEditingController();
  TextEditingController genreC = TextEditingController();

  // Instància de Supabase per gestionar la base de dades
  SupabaseClient client = Supabase.instance.client;

  // Validació per al camp "Edat mínima"
  String? validateMinAge(String value) {
    if (value.isEmpty) {
      return 'Aquest camp és obligatori';
    }
    if (int.tryParse(value) == null) {
      return 'Si us plau, introdueix un número a l\'edat mínima';
    }
    return null; // No hi ha errors
  }

  // Mètode per afegir una pel·lícula
  Future<bool> addNote() async {
    // Comprovem que tots els camps obligatoris estiguin omplerts
    if (titleC.text.isEmpty || descC.text.isEmpty || genreC.text.isEmpty) {
      Get.snackbar("Error", "Tots els camps són obligatoris");
      return false;
    }

    // Validem que l'edat mínima sigui un número vàlid
    if (validateMinAge(minAgeC.text) != null) {
      Get.snackbar("Error", validateMinAge(minAgeC.text)!);
      return false;
    }

    isLoading.value = true; // Activem l'estat de càrrega

    try {
      // Obtenim l'ID de l'usuari actual des de la base de dades
      List<dynamic> res = await client
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id});
      Map<String, dynamic> user = res.first as Map<String, dynamic>;
      int id = user["id"];

      // Inserim les dades de la nova pel·lícula a la base de dades
      await client.from("movies").insert({
        "user_id": id,
        "title": titleC.text,
        "description": descC.text,
        "min_age": int.parse(minAgeC.text),
        "genre": genreC.text,
        "created_at": DateTime.now().toIso8601String(),
      });

      return true; // Èxit en afegir la pel·lícula
    } catch (e) {
      Get.snackbar("Error", "Hi ha hagut un problema en afegir la pel·lícula");
      return false;
    } finally {
      isLoading.value = false; // Desactivem l'estat de càrrega
    }
  }
}
