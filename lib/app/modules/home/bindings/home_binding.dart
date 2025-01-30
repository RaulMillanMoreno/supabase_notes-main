import 'package:get/get.dart'; // Importa GetX per a la gestió de dependències

import '../controllers/home_controller.dart'; // Importa el controlador de la pàgina inicial

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Registra el controlador HomeController per a la seva injecció automàtica en la vista
    Get.lazyPut<HomeController>( 
      () => HomeController(),
    );
  }
}
