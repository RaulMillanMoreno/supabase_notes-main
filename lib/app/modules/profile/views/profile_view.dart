// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:supabase_notes/app/controllers/auth_controller.dart'; 
import 'package:supabase_notes/app/routes/app_pages.dart'; 
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>(); // Obté una instància del controlador d'autenticació

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'), 
          centerTitle: true,
          actions: [
            // Botó per tancar la sessió
            TextButton(
                onPressed: () async {
                  await controller.logout(); 
                  await authC.resetTimer(); // Restaura el temporitzador de l'autenticació
                  Get.offAllNamed(Routes.LOGIN); // Redirigeix a la pantalla de login
                },
                child: const Text(
                  "LOGOUT", // Text del botó de logout
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: FutureBuilder(
            future: controller.getProfile(), // Crida a la funció que carrega el perfil
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(), // Mostra un indicador de càrrega
                );
              }
              return ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  // Mostra el correu electrònic de l'usuari
                  Center(
                    child: Text(
                      controller.emailC.text,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Camp de text per al nom de l'usuari
                  TextField(
                    autocorrect: false,
                    controller: controller.nameC2,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Camp de text per a la nova contrasenya
                  TextField(
                    autocorrect: false,
                    controller: controller.passwordC,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: "New password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Botó per actualitzar el perfil
                  Obx(() => ElevatedButton(
                        onPressed: () async {
                          if (controller.isLoading.isFalse) {
                            // Verifica si no hi ha dades a actualitzar
                            if (controller.nameC.text == controller.nameC2.text &&
                                controller.passwordC.text.isEmpty) {
                              Get.snackbar("Info", "There is no data to update",
                                  borderWidth: 1,
                                  borderColor: Colors.white,
                                  barBlur: 100); // Mostra un missatge si no hi ha res per actualitzar
                              return;
                            }
                            await controller.updateProfile(); // Crida per actualitzar el perfil
                            if (controller.passwordC.text.isNotEmpty &&
                                controller.passwordC.text.length >= 6) {
                              // Si la contrasenya ha estat canviada, tanca la sessió
                              await controller.logout();
                              await authC.resetTimer();
                              Get.offAllNamed(Routes.LOGIN); // Redirigeix a login
                            }
                          }
                        },
                        child: Text(controller.isLoading.isFalse
                            ? "UPDATE PROFILE" // Text del botó segons si està en càrrega
                            : "Loading..."),
                      )),
                ],
              );
            }));
  }
}
