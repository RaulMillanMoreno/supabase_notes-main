// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart'; 
import 'package:supabase_notes/app/modules/home/controllers/home_controller.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  // Recuperem la pel·lícula que volem editar des de l'argument passat a la vista
  Movies note = Get.arguments;
  
  // Obtenció del controlador HomeController per actualitzar la llista de pel·lícules
  HomeController homeC = Get.find();

  EditNoteView({super.key}); // Constructor per a la vista d'edició de pel·lícula

  @override
  Widget build(BuildContext context) {
    // Inicialitzem els camps de text amb la informació de la pel·lícula que es vol editar
    controller.titleC.text = note.title!;
    controller.descC.text = note.description!;
    controller.genreC.text = note.genre!;
    controller.minAgeC.text = note.minAge!.toString();
    
    // Construïm la vista
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Movie'),
          centerTitle: true, // Centrem el títol de l'app bar
        ),
        body: ListView(
          padding: const EdgeInsets.all(20), // Afegim espai a l'interior de la llista
          children: [
            // Camp de text per editar el títol
            TextField(
              controller: controller.titleC,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Camp de text per editar l'edat mínima
            TextField(
              controller: controller.minAgeC,
              decoration: const InputDecoration(
                labelText: "Min Age",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Camp de text per editar el gènere
            TextField(
              controller: controller.genreC,
              decoration: const InputDecoration(
                labelText: "Genre",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Camp de text per editar la descripció
            TextField(
              controller: controller.descC,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Botó per actualitzar la pel·lícula
            Obx(() => ElevatedButton(
                onPressed: () async {
                  // Si no estem en estat de càrrega
                  if (controller.isLoading.isFalse) {
                    // Intentem editar la pel·lícula amb l'ID de la pel·lícula
                    bool res = await controller.editNote(note.id!);
                    // Si l'edició és exitosa, actualitzem la llista de pel·lícules
                    if (res == true) {
                      await homeC.getAllNotes();
                      Get.back(); // Tornem enrere a la pantalla anterior
                    }
                    controller.isLoading.value = false; // Desactivem l'estat de càrrega
                  }
                },
                child: Text(
                    // Mostrem el text segons l'estat de càrrega
                    controller.isLoading.isFalse ? "Edit movie" : "Loading..."))),
          ],
        ));
  }
}
