import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  RxList allNotes = List<Movies>.empty().obs;
  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllNotes() async {
    List<dynamic> res = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id});
    Map<String, dynamic> user = (res).first as Map<String, dynamic>;
    int id = user["id"]; //get user id before get all notes data
    var notes = await client.from("movies").select().match(
      {"user_id": id}, //get all notes data with match user id
    );
    List<Movies> notesData = Movies.fromJsonList((notes as List));
    allNotes(notesData);
    allNotes.refresh();
  }

  Future<void> deleteNote(int id) async {
    await client.from("movies").delete().match({
      "id": id,
    });
    getAllNotes();
  }
}
