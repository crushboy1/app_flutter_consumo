import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumo_electrico_app/firebase_options.dart';
import 'package:consumo_electrico_app/presentation/habits_screen.dart';
import 'package:consumo_electrico_app/presentation/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:consumo_electrico_app/presentation/providers/splash_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference usuario = db.collection('usuario');

  final DocumentSnapshot snapshot =
      await usuario.doc('aoi4tZyQyoLLyN0cSCMK').get();
  final campoUsuario = snapshot.data();
  debugPrint(campoUsuario.toString());
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => SplashProvider())],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(fontFamily: "SF-Pro-Text"),
      initialRoute: 'SplashScreen',
      routes: {
        'SplashScreen': (context) => const SplashScreen(),
        'HabitsScreen': (context) => const HabitsScreen(),
      },
    );
  }
}
