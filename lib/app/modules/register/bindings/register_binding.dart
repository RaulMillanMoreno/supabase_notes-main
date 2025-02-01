import 'package:get/get.dart'; 
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // Registra el controlador de registre en el sistema de dependències de GetX
    Get.lazyPut<RegisterController>(
      () => RegisterController(), // Instància del controlador de registre
    );
  }
}
