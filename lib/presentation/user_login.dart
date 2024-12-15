import 'package:consumo_electrico_app/widget/consts.dart';
import 'package:consumo_electrico_app/widget/mainwrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:consumo_electrico_app/presentation/user_register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

final _auth = FirebaseAuth.instance;

class _UserLoginState extends State<UserLogin> {
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [g1, g2]),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.015),
            child: OverflowBar(
              overflowSpacing: size.height * 0.014,
              overflowAlignment: OverflowBarAlignment.center,
              children: [
                Image.asset(image1, width: 250, height: 250, fit: BoxFit.cover),
                Text(
                  'Bienvenidos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: kWhiteColor.withOpacity(0.7),
                  ),
                ),
                Text(
                  'Por Favor Ingrese Credenciales',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: kWhiteColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: size.height * 0.024),
                TextField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: kInputColor),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    filled: true,
                    hintText: 'Email',
                    prefix: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.login_rounded,
                        )),
                    //prefix: IconButton(onPressed: (){}, icon: SvgPicture.asset(userIcon)),
                    fillColor: kWhiteColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
                TextField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: kInputColor),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    filled: true,
                    hintText: 'Password',
                    prefix: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.key_rounded,
                        )),
                    //prefix: IconButton(onPressed: (){}, icon: SvgPicture.asset(userIcon)),
                    fillColor: kWhiteColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: size.height * 0.080,
                    decoration: BoxDecoration(
                      color: kButtonColor,
                      borderRadius: BorderRadius.circular(37),
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user.user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Mainwrapper()));
                      }
                    } on FirebaseAuthException catch (e) {
                      String errorMessage =
                          'Ocurrió un error inesperado. Por favor, inténtalo nuevamente.';
                      switch (e.code) {
                        case 'user-not-found':
                          errorMessage =
                              'Usuario no encontrado. Por favor, verifica el correo electrónico.';
                          break;
                        case 'wrong-password':
                          errorMessage =
                              'Contraseña incorrecta. Por favor, inténtalo nuevamente.';
                          break;
                        case 'invalid-email':
                          errorMessage =
                              'El formato del correo electrónico es incorrecto.';
                          break;
                        case 'user-disabled':
                          errorMessage =
                              'La cuenta de usuario ha sido deshabilitada.';
                          break;
                        case 'too-many-requests':
                          errorMessage =
                              'Demasiados intentos fallidos. Por favor, inténtalo más tarde.';
                          break;
                        case 'operation-not-allowed':
                          errorMessage =
                              'El inicio de sesión con correo electrónico y contraseña no está habilitado.';
                          break;
                        default:
                          errorMessage = 'Error: ${e.message}';
                          break;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Ocurrio un error inesperado. Por favor, intentalo nuevamente'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } finally {
                      setState(
                        () {
                          showSpinner = false;
                        },
                      );
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.014,
                ),
                Text(
                  '———————————  O ———————————',
                  style: TextStyle(color: kWhiteColor.withOpacity(0.7)),
                ),
                SizedBox(
                  height: size.height * 0.014,
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: size.height * 0.080,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 45,
                              spreadRadius: 0,
                              color: Color.fromRGBO(120, 37, 139, 0.25))
                        ],
                        borderRadius: BorderRadius.circular(37),
                        color: const Color.fromRGBO(255, 255, 255, 0.28)),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(
                        color: kWhiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserRegister()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
