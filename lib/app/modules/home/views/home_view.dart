import 'package:flutter/material.dart'; // Importa Material Design per a la creació de la interfície
import 'package:get/get.dart'; // Importa GetX per a la gestió de l'estat i la navegació
import 'package:supabase_notes/app/data/models/notes_model.dart'; // Importa el model de pel·lícules (Movies)
import 'package:supabase_notes/app/routes/app_pages.dart'; // Importa les rutes definides per a la navegació

import '../controllers/home_controller.dart'; // Importa el controlador de la pàgina inicial (Home)

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HOME'), // Títol de la pàgina principal
          centerTitle: true, // Centra el títol de l'aplicació
          actions: [
            IconButton(
              onPressed: () async {
                // Quan es fa clic al botó de perfil, redirigeix a la pàgina de perfil
                Get.toNamed(Routes.PROFILE);
              },
              icon: const Icon(Icons.person), // Icona de perfil
            )
          ],
        ),
        body: FutureBuilder(
            // Utilitza FutureBuilder per obtenir les dades de les pel·lícules de manera asíncrona
            future: controller.getAllNotes(), // Crida el mètode del controlador per obtenir les pel·lícules
            builder: (context, snapshot) {
              // Controla l'estat de la connexió a la base de dades
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator()); // Mostra un indicador de càrrega mentre s'esperen les dades
              }
              return Obx(() => controller.allNotes.isEmpty
                  // Si la llista de pel·lícules està buida, mostra un missatge indicant-ho
                  ? const Center(
                      child: Text("NO MOVIE"),
                    )
                  : ListView.builder(
                      // Si hi ha pel·lícules, crea una llista per mostrar-les
                      itemCount: controller.allNotes.length, // Nombre de pel·lícules a mostrar
                      itemBuilder: (context, index) {
                        Movies note = controller.allNotes[index]; // Obtenim una pel·lícula de la llista
                        return ListTile(
                          onTap: () => Get.toNamed(
                            Routes.EDIT_NOTE, // Quan es fa clic en una pel·lícula, es va a la pàgina d'edició
                            arguments: note, // Passem la pel·lícula a la següent pantalla com a argument
                          ),
                          leading: CircleAvatar(
                            child: Text("t${note.id}"), // Mostra l'ID de la pel·lícula dins d'un avatar
                          ),
                          title: Text("title: ${note.title}"), // Mostra el títol de la pel·lícula
                          subtitle: Text("description: ${note.description}"), // Mostra la descripció de la pel·lícula
                          trailing: IconButton(
                            onPressed: () async =>
                                await controller.deleteNote(note.id!), // Quan es fa clic a l'icona de l'escombraria, s'elimina la pel·lícula
                            icon: const Icon(Icons.delete), // Icona de l'escombraria
                          ),
                        );
                      },
                    ));
            }),
        floatingActionButton: FloatingActionButton(
          // Botó flotant per afegir una nova pel·lícula
          onPressed: () => Get.toNamed(Routes.ADD_NOTE), // Redirigeix a la pàgina d'afegir pel·lícula
          child: const Icon(Icons.add), // Icona d'afegir
        ));
  }
}
