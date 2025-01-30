import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditNoteController extends GetxController {
  RxBool isLoading = false.obs; // Para manejar el estado de carga
  RxBool isHidden = true.obs; // Para ocultar/mostrar ciertos elementos (opcional)
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController minAgeC = TextEditingController();
  TextEditingController genreC = TextEditingController();
  SupabaseClient client = Supabase.instance.client;

  // Validación directa en el campo
  String? validateMinAge(String value) {
    if (value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    if (int.tryParse(value) == null) {
      return 'Por favor, ingresa un número en Min Age';
    }
    return null; // No hay errores
  }

  // Método para editar la nota
  Future<bool> editNote(int id) async {
    // Validamos que todos los campos estén llenos
    if (titleC.text.isEmpty || descC.text.isEmpty || genreC.text.isEmpty) {
      Get.snackbar("Error", "Todos los campos son obligatorios");
      return false;
    }

    // Validamos que el valor de "Min Age" sea correcto
    if (validateMinAge(minAgeC.text) != null) {
      Get.snackbar("Error", validateMinAge(minAgeC.text)!);
      return false;
    }

    isLoading.value = true; // Iniciar estado de carga

    try {
      // Actualizar la película en la base de datos
      await client
          .from("movies")
          .update({
            "title": titleC.text,
            "description": descC.text,
            "min_age": int.parse(minAgeC.text),
            "genre": genreC.text,
          })
          .match({"id": id});

      return true; // Éxito al editar
    } catch (e) {
      Get.snackbar("Error", "Hubo un problema al editar la película");
      return false; // Error al editar
    } finally {
      isLoading.value = false; // Detener el estado de carga
    }
  }
}
