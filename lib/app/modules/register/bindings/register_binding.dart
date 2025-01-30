import 'package:get/get.dart'; // Importa GetX per gestionar les dependències

import '../controllers/register_controller.dart'; // Importa el controlador de registre

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // Registra el controlador de registre en el sistema de dependències de GetX
    Get.lazyPut<RegisterController>(
      () => RegisterController(), // Instància del controlador de registre
    );
  }
}
