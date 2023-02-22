import 'package:flutter/material.dart';
import 'package:lecalianshop/pages/singup_page.dart';
import 'package:lecalianshop/pages/welcome_page.dart';
import 'package:lecalianshop/utils/massage.dart';
import 'package:lecalianshop/widget/icon_container.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool _contraseniavisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 13, 11, 38),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 70,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'LECALIAN SHOP',
                style: TextStyle(
                    fontFamily: 'RibeyeMarrow',
                    fontSize: 25.0,
                    color: Color.fromARGB(255, 91, 235, 68)),
              ),
              const IconContainer(
                url: 'assets/images/login.png',
              ),
              const Divider(
                height: 15.0,
                color: Color(0x00F1E0AA),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 222, 217, 217),
                    prefixIcon: const Icon(Icons.email,
                        color: Color.fromARGB(255, 13, 11, 38)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11.0)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 95, 231, 250), width: 2),
                    ),
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 96, 86, 86),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 20.0,
                color: Color(0x00F1E0AA),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: TextField(
                  controller: _contrasenaController,
                  obscureText: !_contraseniavisible,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 222, 217, 217),
                    hintText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outline_rounded,
                        color: Color.fromARGB(255, 13, 11, 38)),
                    suffixIcon: IconButton(
                      icon: Icon(_contraseniavisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _contraseniavisible = !_contraseniavisible;
                        });
                      },
                      color: const Color.fromARGB(255, 95, 231, 250),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 95, 231, 250), width: 2),
                    ),
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 96, 86, 86),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 30.0,
                color: Color(0x00F1E0AA),
              ),
              SizedBox(
                width: 235.0,
                height: 51.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (_emailController.value.text.isEmpty) {
                      mostrarSnackBar('Introduzca su Correo', context);
                    } else if (!_emailController.text.contains('@')) {
                      mostrarSnackBar('Introduzca un correo valido', context);
                    } else if (_contrasenaController.value.text.isEmpty) {
                      mostrarSnackBar('Introduzca la Contraseña', context);
                    } else if (_contrasenaController.text.length < 6) {
                      mostrarSnackBar(
                          'La contraseña debe contener al menos 6 caracteres',
                          context);
                    } else {
                      Logear(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 95, 231, 250)),
                  child: const Text(
                    'INICIAR SESIÓN',
                    style: TextStyle(
                      color: Color.fromARGB(255, 96, 86, 86),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 50.0,
                color: Color(0x00F1E0AA),
              ),
              TextButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Singup()))
                },
                child: const Text('¿Si aun no tiene cuenta REGISTRARE?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 252, 252),
                        fontFamily: 'Roboto',
                        fontSize: 12.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

// ignore: non_constant_identifier_names
  Future<void> Logear(BuildContext context) async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        // ignore: unused_local_variable
        UserCredential credencial = await auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _contrasenaController.text.trim());
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Welcome()));
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          mostrarSnackBar("Usuario Desconocido", context);
        } else if (e.code == "wrong-password") {
          mostrarSnackBar("Contraseña Incorrecta", context);
        } else {
          mostrarSnackBar("Usuario/Contraseña Incorrectas", context);
        }
      }
    }
  }
}
