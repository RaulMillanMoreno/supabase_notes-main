// ignore_for_file: constant_identifier_names

// Importa GetX per a la gestió de rutes i controladors
import 'package:get/get.dart';

// Importa les vistes i els bindings de les diferents pantalles de l'aplicació
import 'package:supabase_notes/app/modules/add_note/bindings/add_note_binding.dart';
import 'package:supabase_notes/app/modules/add_note/views/add_note_view.dart';
import 'package:supabase_notes/app/modules/edit_note/bindings/edit_note_binding.dart';
import 'package:supabase_notes/app/modules/edit_note/views/edit_note_view.dart';
import 'package:supabase_notes/app/modules/home/bindings/home_binding.dart';
import 'package:supabase_notes/app/modules/home/views/home_view.dart';
import 'package:supabase_notes/app/modules/login/bindings/login_binding.dart';
import 'package:supabase_notes/app/modules/login/views/login_view.dart';
import 'package:supabase_notes/app/modules/profile/bindings/profile_binding.dart';
import 'package:supabase_notes/app/modules/profile/views/profile_view.dart';
import 'package:supabase_notes/app/modules/register/bindings/register_binding.dart';
import 'package:supabase_notes/app/modules/register/views/register_view.dart';

// Importa les rutes, les seccions de rutes poden estar en un arxiu separat per ordre
part 'app_routes.dart';

// Classe que gestiona les rutes de l'aplicació
class AppPages {
  // Constructor privat per evitar la instanciació d'aquesta classe
  AppPages._();

  // Ruta inicial quan l'aplicació s'inicia
  static const INITIAL = Routes.HOME;

  // Definició de totes les rutes de l'aplicació
  static final routes = [
    // Ruta per a la pàgina principal (Home)
    GetPage(
      name: _Paths.HOME, // Ruta: '/home'
      page: () => const HomeView(), // Vista de la pàgina principal
      binding: HomeBinding(), // Binding que injecta els controladors necessaris
    ),

    // Ruta per a la pàgina de login
    GetPage(
      name: _Paths.LOGIN, // Ruta: '/login'
      page: () => LoginView(), // Vista de login
      binding: LoginBinding(), // Binding que injecta el controlador de login
    ),

    // Ruta per a la pàgina de registre
    GetPage(
      name: _Paths.REGISTER, // Ruta: '/register'
      page: () => const RegisterView(), // Vista de registre
      binding: RegisterBinding(), // Binding que injecta el controlador de registre
    ),

    // Ruta per a la pàgina de perfil de l'usuari
    GetPage(
      name: _Paths.PROFILE, // Ruta: '/profile'
      page: () => ProfileView(), // Vista de perfil
      binding: ProfileBinding(), // Binding que injecta el controlador de perfil
    ),

    // Ruta per a la pàgina d'afegir pel·lícula
    GetPage(
      name: _Paths.ADD_NOTE, // Ruta: '/add_note'
      page: () => AddNoteView(), // Vista per afegir pel·lícula
      binding: AddNoteBinding(), // Binding que injecta el controlador d'afegir pel·lícula
    ),

    // Ruta per a la pàgina d'editar pel·lícula
    GetPage(
      name: _Paths.EDIT_NOTE, // Ruta: '/edit_note'
      page: () => EditNoteView(), // Vista per editar pel·lícula
      binding: EditNoteBinding(), // Binding que injecta el controlador d'editar pel·lícula
    ),
  ];
}
