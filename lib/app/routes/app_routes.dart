// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';
// NO EDITAR. Aquest codi és generat automàticament per package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  // Rutes de l'aplicació
  static const HOME = _Paths.HOME; // Ruta per veure les pel·lícules
  static const LOGIN = _Paths.LOGIN; // Ruta per al login de l'usuari
  static const REGISTER = _Paths.REGISTER; // Ruta per al registre de l'usuari
  static const PROFILE = _Paths.PROFILE; // Ruta per veure el perfil de l'usuari
  static const ADD_NOTE = _Paths.ADD_NOTE; // Ruta per afegir una nova pel·lícula
  static const EDIT_NOTE = _Paths.EDIT_NOTE; // Ruta per editar una pel·lícula existent
}

abstract class _Paths {
  // Definició de les rutes de l'aplicació amb els seus camins associats
  static const HOME = '/home'; // Pàgina principal amb la llista de pel·lícules
  static const LOGIN = '/login'; // Pàgina de login per a l'autenticació de l'usuari
  static const REGISTER = '/register'; // Pàgina de registre per crear un compte d'usuari
  static const PROFILE = '/profile'; // Pàgina de perfil de l'usuari, on es pot veure i modificar la informació
  static const ADD_NOTE = '/add-note'; // Pàgina per afegir una nova pel·lícula
  static const EDIT_NOTE = '/edit-note'; // Pàgina per editar les dades d'una pel·lícula existent
}
