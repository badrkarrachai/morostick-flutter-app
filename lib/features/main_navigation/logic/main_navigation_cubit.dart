import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/features/main_navigation/logic/main_navigation_state.dart';

class MainNavigationCubit extends Cubit<MainNavigationState> {
  MainNavigationCubit() : super(const MainNavigationState());

  void selectIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
