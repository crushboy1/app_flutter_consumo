import 'package:consumo_electrico_app/widget/create_habit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset('assets/lottie/capibara.json'),
          const Text(
            'Todavia no hay ningun habito. \n !Pulsa << + >> para agregar un hábito!',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                fontFamily: 'SF-Pro-Text-Regular.otf'),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateHabitDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
