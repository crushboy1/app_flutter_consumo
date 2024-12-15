import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(const DrawerState(selectedItem: NavItem.homeScreen)) {
    on<NavigateTo>((event, emit) {
      if (event.destination != state.selectedItem) {
        emit(DrawerState(selectedItem: event.destination));
      }
    });
  }
}
