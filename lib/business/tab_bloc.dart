import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/services/services.dart';

import '../domain/tab_item.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitialState());

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if (event == TabEvent.initializing) {
      final tabs = await getTabService().getTabs();
      yield TabsLoadedState(tabs: tabs);
    }
  }
}

enum TabEvent { initializing }

abstract class TabState {}

class TabInitialState extends TabState {}

class TabsLoadedState extends TabState {
  final List<TabItem> tabs;

  TabsLoadedState({this.tabs = const []});
}
