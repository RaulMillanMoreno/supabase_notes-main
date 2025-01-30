import 'package:get/get.dart'; // Importa GetX per la gestió de l'estat i dependències
import 'package:supabase_notes/app/data/models/notes_model.dart'; // Importa el model de les pel·lícules (Movies)
import 'package:supabase_flutter/supabase_flutter.dart'; // Importa Supabase per a la comunicació amb la base de dades

class HomeController extends GetxController {
  // Llista reactiva que emmagatzema totes les pel·lícules
  RxList allNotes = List<Movies>.empty().obs;

  // Instància de SupabaseClient per interactuar amb la base de dades
  SupabaseClient client = Supabase.instance.client;

  // Mètode per obtenir totes les pel·lícules de l'usuari actual
  Future<void> getAllNotes() async {
    // Obtenim l'ID de l'usuari actual
    List<dynamic> res = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    int id = user["id"]; // Recuperem l'ID de l'usuari

    // Obtenim totes les pel·lícules associades a aquest ID d'usuari
    var notes = await client.from("movies").select().match(
      {"user_id": id}, // Filtratge per obtenir les pel·lícules de l'usuari
    );

    // Convertim les dades obtingudes en una llista de pel·lícules
    List<Movies> notesData = Movies.fromJsonList((notes as List));
    
    // Actualitzem la llista de pel·lícules a la variable reactiva
    allNotes(notesData);
    allNotes.refresh(); // Forcem una actualització de la llista per mostrar els canvis
  }

  // Mètode per eliminar una pel·lícula per ID
  Future<void> deleteNote(int id) async {
    // Eliminem la pel·lícula de la base de dades
    await client.from("movies").delete().match({
      "id": id,
    });
    // Un cop eliminada, actualitzem la llista de pel·lícules
    getAllNotes();
  }
}
