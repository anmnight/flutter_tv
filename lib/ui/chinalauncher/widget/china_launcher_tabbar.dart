import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/tab_bloc.dart';
import 'package:flutter_tv/ui/chinalauncher/widget/china_home_page.dart';
import 'package:flutter_tv/ui/widgets/tv_focusable_wrap.dart';

import '../../../domain/tab_item.dart';

class ChinaLauncherTabBar extends StatefulWidget {
  const ChinaLauncherTabBar({
    Key? key,
  }) : super(key: key);

  @override
  State<ChinaLauncherTabBar> createState() => _ChinaLauncherTabBarState();
}

class _ChinaLauncherTabBarState extends State<ChinaLauncherTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBloc>(
      create: (_) => TabBloc()..add(TabEvent.initializing),
      child: BlocBuilder<TabBloc, TabState>(
        builder: (context, state) {
          if (state is TabsLoadedState) {
            List<TabItem> tabs = state.tabs;

            _tabController = TabController(length: tabs.length, vsync: this);

            return Scaffold(
              appBar: TabBar(
                controller: _tabController,
                tabs: tabs
                    .asMap()
                    .entries
                    .map((e) => TvFocusableWrap(
                          child: Text(
                            e.value.name,
                          ),
                          onFocusHandler: () => _tabController.animateTo(e.key),
                        ))
                    .toList(),
              ),
              body: TabBarView(
                controller: _tabController,
                children:
                    tabs.map((e) => ChinaHomePage(tabId: e.tabId)).toList(),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
