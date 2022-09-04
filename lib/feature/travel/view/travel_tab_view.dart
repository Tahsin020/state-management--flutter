import 'package:flutter/material.dart';
import 'package:state_managements_in_life/feature/travel/view/travel_view.dart';

enum TravelPage {
  home,
  bookmark,
  notification,
  profile,
}

class TravelTabView extends StatelessWidget {
  const TravelTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TravelPage.values.length,
      child: const Scaffold(
        bottomNavigationBar: BottomAppBar(child: TabBar(tabs: [
          Tab(icon: Icon(Icons.accessibility_new),),
          Tab(icon: Icon(Icons.ac_unit),),
          Tab(icon: Icon(Icons.ac_unit),),
          Tab(icon: Icon(Icons.ac_unit),),
        ]),),
        body: TabBarView(children: [
          TravelView(),
          SizedBox(),
          SizedBox(),
          SizedBox(),
        ]),
      ),
    );
  }
}
