import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import 'package:supabase_notes/app/controllers/auth_controller.dart'; 
import 'package:supabase_notes/app/routes/app_pages.dart'; 
import '../controllers/login_controller.dart'; 

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>(); // Obté una instància del controlador d'autenticació

  LoginView({super.key}); // Constructor de la vista, amb suport per a la clau de la vista

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'), 
          centerTitle: true, 
        ),
        body: ListView(
          padding: const EdgeInsets.all(10), // Afegim espai al voltant del contingut
          children: [
            // Camp de text per al correu electrònic
            TextField(
              autocorrect: false, // Desactivem l'autocorrecció
              controller: controller.emailC, // Assignem el controlador per al correu
              textInputAction: TextInputAction.next, // Acció per a avançar al següent camp
              decoration: const InputDecoration(
                labelText: "Email", 
                border: OutlineInputBorder(), // Disseny de frontera per al camp
              ),
            ),
            const SizedBox(
              height: 20, // Espai entre els camps
            ),
            // Camp de text per a la contrasenya amb visibilitat alternant
            Obx(() => TextField(
                  autocorrect: false, // Desactivem l'autocorrecció
                  controller: controller.passwordC, // Assignem el controlador per a la contrasenya
                  textInputAction: TextInputAction.done, // Acció de finalització
                  obscureText: controller.isHidden.value, // Activa/desactiva la visibilitat de la contrasenya
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => controller.isHidden.toggle(), // Canvia l'estat de visibilitat
                        icon: controller.isHidden.isTrue
                            ? const Icon(Icons.remove_red_eye) 
                            : const Icon(Icons.remove_red_eye_outlined)),
                    labelText: "Password", 
                    border: const OutlineInputBorder(), // Disseny de frontera per al camp
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            // Botó de login amb missatge que canvia segons l'estat de càrrega
            Obx(() => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) { // Comprovem que no estigui en procés de càrrega
                      bool? cekAutoLogout = await controller.login(); // Intentem fer login
                      if (cekAutoLogout == true) { // Si el login és exitós
                        await authC.autoLogout(); // Realitzem logout automàtic si és necessari
                        Get.offAllNamed(Routes.HOME); // Naveguem a la pàgina d'inici
                      }
                    }
                  },
                  child: Text(
                      controller.isLoading.isFalse ? "LOGIN" : "Loading..."), // Canviem el text segons l'estat
                )),
            const SizedBox(
              height: 10,
            ),
            // Botó per navegar a la pàgina de registre
            ElevatedButton(
                onPressed: () => Get.toNamed(Routes.REGISTER), // Naveguem a la pàgina de registre
                child: const Text("REGISTER"))
          ],
        ));
  }
}
