import 'package:get/get.dart'; 
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Registra el controlador HomeController per a la seva injecció automàtica en la vista
    Get.lazyPut<HomeController>( 
      () => HomeController(),
    );
  }
}
