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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromRGBO(241, 225, 170, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 50.0,
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
                    color: Colors.green),
              ),
              const IconContainer(
                url: 'assets/images/login.png',
              ),
              const Divider(
                height: 15.0,
                color: Color.fromRGBO(241, 225, 170, 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  enableInteractiveSelection: false,
                  autofocus: false,
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
                height: 20.0,
                color: Color.fromRGBO(241, 225, 170, 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: TextField(
                  controller: _contrasenaController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(222, 217, 217, 1),
                    hintText: 'Contraseña',
                    suffixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              const Divider(
                height: 30.0,
                color: Color.fromRGBO(241, 225, 170, 1),
              ),
              SizedBox(
                width: 235.0,
                height: 51.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_emailController.text.contains('@')) {
                      mostrarSnackBar('Email no correcto', context);
                    } else if (_contrasenaController.text.length < 6) {
                      mostrarSnackBar(
                          'La contraseña debe contener al menos 6 caracteres',
                          context);
                    } else {
                      Logear(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent[400]),
                  child: const Text(
                    'INICIAR SESIÓN',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 50.0,
                color: Color.fromRGBO(241, 225, 170, 1),
              ),
              TextButton(
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Singup()))
                },
                child: const Text('¿Si aun no tiene cuenta REGISTRARE',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Roboto',
                        fontSize: 12.0)),
              ),
            ],
          ),
        ),
      ),
    );
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
          mostrarSnackBar("Usuario desconocido", context);
        } else if (e.code == "wrong-password") {
          mostrarSnackBar("Contraseña incorrecta", context);
        } else {
          mostrarSnackBar("Lo sentimos, hubo un error", context);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }
}
