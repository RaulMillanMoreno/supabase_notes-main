import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditNoteController extends GetxController {
  // Estat per gestionar la càrrega mentre s'editar una pel·lícula
  RxBool isLoading = false.obs;

  // Estat per amagar o mostrar certs elements (opcional)
  RxBool isHidden = true.obs;

  // Controladors dels camps de text per editar la pel·lícula
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

  // Mètode per editar la pel·lícula
  Future<bool> editNote(int id) async {
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
      // Actualitzem la pel·lícula a la base de dades
      await client
          .from("movies")
          .update({
            "title": titleC.text,
            "description": descC.text,
            "min_age": int.parse(minAgeC.text),
            "genre": genreC.text,
          })
          .match({"id": id});

      return true; // Èxit en editar la pel·lícula
    } catch (e) {
      Get.snackbar("Error", "Hi ha hagut un problema en editar la pel·lícula");
      return false; // Error en editar
    } finally {
      isLoading.value = false; // Desactivem l'estat de càrrega
    }
  }
}
