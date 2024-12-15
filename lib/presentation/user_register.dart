import 'package:consumo_electrico_app/widget/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [g1, g2],
        )),
        child: SafeArea(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Bienvenido de Nuevo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: kWhiteColor.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Por Favor Ingrese sus Datos',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: kWhiteColor.withOpacity(0.7),
                  height: 1.2),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            myTextField('Ingrese Email', Colors.white, false),
            const SizedBox(height: 10),
            myTextField('Ingrese Contraseña', Colors.black, true),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Recuperar Contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kWhiteColor.withOpacity(0.7),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
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
                  'Registrar',
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
                  final userCredential =
                      await _auth.createUserWithEmailAndPassword(
                    email: email.trim(),
                    password: password.trim(),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuario Registrado Correctamente'),
                      duration:  Duration(seconds: 3),
                    ),
                  );
                  print(
                      'Usuario registrado con UID: ${userCredential.user!.uid}');
                  Navigator.pop(context);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('La contraseña es muy débil.');
                  } else if (e.code == 'email-already-in-use') {
                    print('El correo ya está en uso');
                  } else {
                    print(e.code);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(getErrorMessage(e.code)),
                    duration: const Duration(seconds: 4),
                  ));
                } finally {
                  setState(() {
                    showSpinner = false;
                  });
                }
              },
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2,
                  width: size.width * 0.2,
                  color: Colors.black12,
                ),
                const Text(
                  ' O continue con ',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 2,
                  width: size.width * 0.2,
                  color: Colors.black12,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                socialIcon('assets/images/google.png'),
                socialIcon('assets/images/apple.png'),
                socialIcon('assets/images/facebook.png'),
              ],
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            const Text.rich(TextSpan(
                text: '¿No eres miembro?  ',
                style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: 'Registrate ahora',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]))
          ],
        )),
      ),
    );
  }

  Container socialIcon(image) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Image.asset(image, height: 35),
    );
  }

  Widget myTextField(String hint, Color color, bool obscureText) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.black),
      onChanged: (value) {
        if (hint == 'Ingrese Email') {
          email = value;
        } else {
          password = value;
        }
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 22,
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black45, fontSize: 19),
        suffixIcon: Icon(
          Icons.visibility_off_outlined,
          color: color,
        ),
      ),
    );
  }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'weak-password':
        return 'La contraseña es muy débil.';
      case 'email-already-in-use':
        return 'El correo electrónico ya está en uso.';
      default:
        return 'Ocurrió un error inesperado.';
    }
  }
}
