import 'package:flutter/material.dart';
import 'package:lecalianshop/utils/massage.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contrasenaController1 = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 225, 170, 1),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 50.0,
          vertical: 70,
        ),
        children: <Widget>[
          SizedBox(
            child: IconButton(
              alignment: Alignment.topLeft,
              icon: const Icon(Icons.arrow_circle_left),
              iconSize: 50.0,
              onPressed: () => {
                Navigator.pop(
                  context,
                )
              },
            ),
          ),
          Column(
            key: _formKey,
            children: <Widget>[
              const Text('¡Crear una cuenta nueva!'),
              const Divider(
                height: 20.0,
                color: Color.fromRGBO(241, 225, 170, 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: TextField(
                  controller: _usuarioController,
                  keyboardType: TextInputType.name,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                    filled: true,
                    fillColor: const Color.fromRGBO(222, 217, 217, 1),
                    suffixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              const Divider(
                height: 25.0,
                color: Color.fromRGBO(241, 225, 170, 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: const Color.fromRGBO(222, 217, 217, 1),
                    suffixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              const Divider(
                height: 25.0,
                color: Color.fromRGBO(241, 225, 170, 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _contrasenaController1,
                  enableInteractiveSelection: false,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    filled: true,
                    fillColor: const Color.fromRGBO(222, 217, 217, 1),
                    suffixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              const Divider(
                height: 25.0,
                color: Color.fromRGBO(241, 225, 170, 1),
              ),
              SizedBox(
                width: 235.0,
                height: 51.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_emailController.text.contains('@')) {
                      mostrarSnackBar('Introduzca un email correcto', context);
                    } else if (_usuarioController.text.isEmpty) {
                      mostrarSnackBar('Introduzca su nombre', context);
                    } else if (_contrasenaController1.text.length < 6) {
                      mostrarSnackBar(
                          'La contraseña debe tener al menos 6 caracteres',
                          context);
                    } else {
                      registrarNuevoUsuario(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent[400]),
                  child: const Text(
                    'REGISTRARSE',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _contrasenaController1.dispose();
    _usuarioController.dispose();
    super.dispose();
  }

  Future<void> registrarNuevoUsuario(BuildContext context) async {
    // ignore: unused_local_variable
    User usuario;
    try {
      usuario = (await auth.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _contrasenaController1.text.trim()))
          .user!;
      // ignore: use_build_context_synchronously
      mostrarSnackBar("Usuario creado correctamente", context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        mostrarSnackBar("Contraseña demasidado débil", context);
      } else if (e.code == "email-already-in-use") {
        mostrarSnackBar("Ese usuario ya existe", context);
      } else {
        mostrarSnackBar("Lo sentimos, hubo un error", context);
      }
    } catch (e) {
      mostrarSnackBar("Lo sentimos, hubo un error", context);
    }
  }
}
