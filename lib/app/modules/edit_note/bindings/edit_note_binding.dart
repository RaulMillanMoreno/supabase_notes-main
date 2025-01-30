import 'package:get/get.dart';
import '../controllers/edit_note_controller.dart';

// Classe que defineix les dependències per a l'edició d'una pel·lícula
class EditNoteBinding extends Bindings {
  @override
  void dependencies() {
    // Registra el controlador EditNoteController amb GetX
    // S'utilitza lazyPut perquè només es creï quan sigui necessari
    Get.lazyPut<EditNoteController>(
      () => EditNoteController(),
    );
  }
}
