import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs; // Para manejar el estado de carga

  // Controladores de los TextFields
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();
  TextEditingController minAgeC = TextEditingController();
  TextEditingController genreC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  // Validación directa en el campo
  String? validateMinAge(String value) {
    if (value.isEmpty) {
      return 'Estos campos son obligatorios';
    }
    if (int.tryParse(value) == null) {
      return 'Por favor, ingresa un número en Min Age';
    }
    return null; // No hay errores
  }

  // Método para agregar una nota
  Future<bool> addNote() async {
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

    isLoading.value = true;

    try {
      // Obtener el ID del usuario actual
      List<dynamic> res = await client
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id});
      Map<String, dynamic> user = res.first as Map<String, dynamic>;
      int id = user["id"];

      // Insertar los datos en la base de datos
      await client.from("movies").insert({
        "user_id": id,
        "title": titleC.text,
        "description": descC.text,
        "min_age": int.parse(minAgeC.text),
        "genre": genreC.text,
        "created_at": DateTime.now().toIso8601String(),
      });

      return true; // Éxito
    } catch (e) {
      Get.snackbar("Error", "Hubo un problema al agregar la película");
      return false;
    } finally {
      isLoading.value = false; // Detener el estado de carga
    }
  }
}
