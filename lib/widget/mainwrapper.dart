import 'package:consumo_electrico_app/bloc/drawer_bloc.dart';
import 'package:consumo_electrico_app/presentation/home_screen.dart';
import 'package:consumo_electrico_app/presentation/profile_screen.dart';
import 'package:consumo_electrico_app/presentation/habits_screen.dart';
import 'package:consumo_electrico_app/presentation/tip_screen.dart';
import 'package:consumo_electrico_app/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consumo_electrico_app/widget/consts.dart';

class Mainwrapper extends StatefulWidget {
  const Mainwrapper({super.key});

  @override
  MainwrapperState createState() => MainwrapperState();
}

class MainwrapperState extends State<Mainwrapper> {
  late DrawerBloc _bloc;

  /// Each item in drawer content
  late Widget _content;
  @override
  void initState() {
    _bloc = DrawerBloc();
    _content = _getContentForState(_bloc.state.selectedItem);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<DrawerBloc, DrawerState>(
        listener: (context, state) {
          _content = _getContentForState(state.selectedItem);
        },

        ///builder when
        buildWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },

        ///Listwhen

        listenWhen: (previous, current) {
          return previous.selectedItem != current.selectedItem;
        },

        ///Builder
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppbar(state),

            drawer: const NavDrawerWidget(),

            ///body
            body: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeInExpo,
                switchOutCurve: Curves.easeOutExpo,
                child: _content),
          );
        },
      ),
    );
  }

  //mainwrapper appbar
  AppBar _buildAppbar(DrawerState state) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        _getAppBarTitle(state.selectedItem),
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: false,
      backgroundColor: g2 ,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  ///content for each drawer item
  Widget _getContentForState(NavItem selectedItem) {
    switch (selectedItem) {
      case NavItem.homeScreen:
        return const HomeScreen();
      case NavItem.profileScreen:
        return const ProfileScreen();
      case NavItem.habitsScreen:
        return const HabitsScreen();
      case NavItem.tipScreen:
        return const TipScreen();
      default:
        return Container();
    }
  }

  String _getAppBarTitle(NavItem selectedItem) {
    switch (selectedItem) {
      case NavItem.homeScreen:
        return 'Home';
      case NavItem.profileScreen:
        return 'Profile';
      case NavItem.habitsScreen:
        return 'Habitos';
        case NavItem.tipScreen:
        return 'Tips para reducir el consumo';
      default:
        return 'Navigation Drawer Demo';
    }
  }
}
