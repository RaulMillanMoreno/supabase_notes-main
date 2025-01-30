// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/modules/home/controllers/home_controller.dart';
import '../controllers/add_note_controller.dart';

// Vista per afegir una pel·lícula
class AddNoteView extends GetView<AddNoteController> {
  // Obtenim el controlador de la pantalla principal per actualitzar la llista de pel·lícules després d'afegir-ne una nova
  HomeController homeC = Get.find();

  AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Movie'), // Títol de la pantalla
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20), // Espaiat per a un millor disseny
          children: [
            // Camp per introduir el títol de la pel·lícula
            TextField(
              controller: controller.titleC,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            // Camp per introduir l'edat mínima per veure la pel·lícula
            TextField(
              controller: controller.minAgeC,
              decoration: const InputDecoration(
                labelText: "Min Age",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            // Camp per introduir el gènere de la pel·lícula
            TextField(
              controller: controller.genreC,
              decoration: const InputDecoration(
                labelText: "Genre",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            // Camp per introduir la descripció de la pel·lícula
            TextField(
              controller: controller.descC,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Botó per afegir la pel·lícula
            Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    bool res = await controller.addNote();
                    if (res == true) {
                      await homeC.getAllNotes(); // Actualitzem la llista de pel·lícules
                      Get.back(); // Tornem enrere després d'afegir la pel·lícula
                    }
                    controller.isLoading.value = false;
                  }
                },
                child: Text(controller.isLoading.isFalse ? "Add movie" : "Loading..."))),
          ],
        ));
  }
}
