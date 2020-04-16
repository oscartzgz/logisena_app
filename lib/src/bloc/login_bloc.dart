// Crear streams para validar que sean correctos los campos

import 'dart:async';
import 'package:logisena/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Los "get" solo son una conveniencia
  // para no apuntar a _emailcontroler(punto) tal y tal etc..

  // Recuperar los datos del stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);


  Stream<bool> get formValidStream =>
      CombineLatestStream.combine2( emailStream, passwordStream, (e, p) => true );

  // Insertar valores al stream
  Function(String) get changeEmail   => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener último valor ingresado a los streams
  String get email    => _emailController.value;
  String get password => _passwordController.value;

  // Cerrar los streams
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

}