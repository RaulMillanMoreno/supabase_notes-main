import 'package:get/get.dart';

import '../controllers/add_note_controller.dart';

// Classe que defineix les dependències per a la pantalla d'afegir una pel·lícula
class AddNoteBinding extends Bindings {
  @override
  void dependencies() {
    // Registra el controlador AddNoteController amb GetX
    // S'utilitza lazyPut perquè només es creï quan sigui necessari
    Get.lazyPut<AddNoteController>(
      () => AddNoteController(),
    );
  }
}