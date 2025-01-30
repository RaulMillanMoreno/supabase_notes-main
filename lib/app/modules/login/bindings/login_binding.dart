import 'package:get/get.dart'; // Importa GetX per a la gestió de dependències
import '../controllers/login_controller.dart'; // Importa el controlador de login

// Aquesta classe és responsable de la injecció de dependències per a la pàgina de login
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Registra el LoginController per a la injecció de dependències
    // `lazyPut` crea la instància del controlador quan és necessari (primer cop que es fa servir)
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
