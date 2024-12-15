import 'package:consumo_electrico_app/bloc/drawer_bloc.dart';
import 'package:consumo_electrico_app/widget/consts.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _NavigationItem {
  final NavItem item;
  final String title;
  final IconData icon;

  _NavigationItem(
    this.item,
    this.title,
    this.icon,
  );
}

class NavDrawerWidget extends StatefulWidget {
  const NavDrawerWidget({super.key});

  @override
  State<NavDrawerWidget> createState() => _NavDrawerWidgetState();
}

class _NavDrawerWidgetState extends State<NavDrawerWidget> {
  ///Drawer items
  final List<_NavigationItem> _drawItems = [
    //HOME
    _NavigationItem(NavItem.homeScreen, 'Home', IconlyBold.home),
    //PROFILE
    _NavigationItem(NavItem.profileScreen, 'Profile', IconlyBold.profile),
    //HABITS
    _NavigationItem(NavItem.habitsScreen, 'Habits', IconlyBold.heart),
    //TIPS
    _NavigationItem(NavItem.tipScreen, 'Tips', IconlyBold.info_circle)
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ///Header
          const UserAccountsDrawerHeader(
            accountName: Text(
              'David',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('jreyesc@autonoma.edu.pe',
                style: TextStyle(color: Colors.white)),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://blog.sebastiano.dev/content/images/2019/07/1_l3wujEgEKOecwVzf_dqVrQ.jpeg')),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/91388754?v=4'),
            ),
          ),

          ///Item
          ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _drawItems.length,
              shrinkWrap: true,
              itemBuilder: (ctx, i) {
                return BlocBuilder<DrawerBloc, DrawerState>(
                  buildWhen: (previus, current) {
                    return previus.selectedItem != current.selectedItem;
                  },
                  builder: (context, state) => _buildItem(_drawItems[i], state),
                );
              })
        ],
      ),
    );
  }

  Widget _buildItem(_NavigationItem data, DrawerState state) =>
      _makeListItem(data, state);

  Widget _makeListItem(_NavigationItem data, DrawerState state) {
    return Card(
      color: Colors.grey[100],
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      borderOnForeground: true,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: ListTile(
        title: Text(
          data.title,
          style: TextStyle(
            fontWeight: data.item == state.selectedItem
                ? FontWeight.bold
                : FontWeight.w300,
            color: data.item == state.selectedItem
                ? g2
                : Colors.grey[600]
          ),
        ),
        leading: Icon(
          data.icon,
          color: data.item == state.selectedItem
              ? g2
              : Colors.grey[600],
        ),
        onTap: () => _handlerItemClick(context, data.item),
      ),
    );
  }

  /// tap
  void _handlerItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<DrawerBloc>(context).add(NavigateTo(item));
    //Navigator.pop(context);
  }
}
