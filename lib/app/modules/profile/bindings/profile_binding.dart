import 'package:get/get.dart'; // Importa GetX per a la gestió de dependències

import '../controllers/profile_controller.dart'; // Importa el controlador del perfil

class ProfileBinding extends Bindings { // Classe que implementa la funció de Bindings
  @override
  void dependencies() { // Sobrescrivim el mètode dependencies() per definir les dependències
    Get.lazyPut<ProfileController>( // Es defineix una dependència lazy per al controlador del perfil
      () => ProfileController(), // Quan sigui necessari, GetX crearà una instància del controlador
    );
  }
}
