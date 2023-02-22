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
  // ignore: unused_field
  bool _contraseniavisible1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 13, 11, 38),
            body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 70,
                ),
                child: Form(
                    child: Column(
                  key: _formKey,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(255, 255, 252, 252),
                      ),
                      iconSize: 50.0,
                      onPressed: () => {
                        Navigator.pop(
                          context,
                        )
                      },
                    ),
                    const Text('REGISTRO',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 252, 252),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                          '_______________________________________________',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 252, 252),
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    const Text('¡Crear una cuenta nueva!',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 252, 252),
                          fontFamily: 'Ronoto',
                          fontSize: 16,
                        )),
                    const Divider(
                      height: 25.0,
                      color: Color(0x00F1E0AA),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        controller: _usuarioController,
                        keyboardType: TextInputType.name,
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                          hintText: 'Nombre',
                          filled: true,
                          fillColor: const Color.fromARGB(255, 222, 217, 217),
                          prefixIcon: const Icon(Icons.person,
                              color: Color.fromARGB(255, 13, 11, 38)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 95, 231, 250),
                                width: 2),
                          ),
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 96, 86, 86),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 25.0,
                      color: Color(0x00F1E0AA),
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
                          fillColor: const Color.fromARGB(255, 222, 217, 217),
                          prefixIcon: const Icon(Icons.email,
                              color: Color.fromARGB(255, 13, 11, 38)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 95, 231, 250),
                                width: 2),
                          ),
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 96, 86, 86),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 25.0,
                      color: Color(0x00F1E0AA),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: TextField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _contrasenaController1,
                        enableInteractiveSelection: false,
                        obscureText: !_contraseniavisible1,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          filled: true,
                          fillColor: const Color.fromARGB(255, 222, 217, 217),
                          prefixIcon: const Icon(Icons.lock_outline,
                              color: Color.fromARGB(255, 13, 11, 38)),
                          suffixIcon: IconButton(
                            icon: Icon(_contraseniavisible1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _contraseniavisible1 = !_contraseniavisible1;
                              });
                            },
                            color: const Color.fromARGB(255, 95, 231, 250),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 95, 231, 250),
                                width: 2),
                          ),
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 96, 86, 86),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 25.0,
                      color: Color(0x00F1E0AA),
                    ),
                    SizedBox(
                      width: 235.0,
                      height: 51.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_usuarioController.text.isEmpty) {
                            mostrarSnackBar('Introduzca su Nombre', context);
                          } else if (_emailController.value.text.isEmpty) {
                            mostrarSnackBar('Introduzca el Correo', context);
                          } else if (!_emailController.text.contains('@')) {
                            mostrarSnackBar(
                                'Introduzca un email correcto', context);
                          } else if (_contrasenaController1
                              .value.text.isEmpty) {
                            mostrarSnackBar(
                                'Introduzca la Contraseña', context);
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
                            color: Color.fromARGB(255, 96, 86, 86),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                )))),
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
