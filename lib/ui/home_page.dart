import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzzflutter/blocs/home/home_bloc.dart';
import 'package:newzzflutter/constants/dimens.dart';
import 'package:newzzflutter/ui/common_widgets/platform_svg.dart';
import 'package:newzzflutter/ui/pages/business_list_widget.dart';
import 'package:newzzflutter/ui/pages/technology_list_widget.dart';

import 'pages/general_list_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final general = 'General';
  static final business = 'Business';
  static final technology = 'Technology';

  String title = general;
  final _pageController = PageController();

  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, int>(
        builder: (context, index) {
          return Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 40.0, 0.0, 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    children: <Widget>[
                      GeneralListWidget(),
                      BusinessListWidget(),
                      TechnologyListWidget()
                    ],
                    onPageChanged: (index) {
                      _homeBloc.add(UpdatePageEvent(index: index));
                      _changeTitle(index);
                    },
                    controller: _pageController,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, int>(
        builder: (context, index) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            items: getBottomNavigationItems(context, index),
            onTap: (index) {
              _homeBloc.add(UpdatePageEvent(index: index));
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.easeIn);
              _changeTitle(index);
            },
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> getBottomNavigationItems(
      BuildContext context, int index) {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        title: SizedBox.shrink(),
        icon: SvgWidget(
          assetPath: 'assets/icons/general.svg',
          width: Dimen.bottomNavIconSize,
          height: Dimen.bottomNavIconSize,
          color: index == 0 ? Theme.of(context).primaryColor : Colors.black,
        ),
      ),
      BottomNavigationBarItem(
        title: SizedBox.shrink(),
        icon: SvgWidget(
          assetPath: 'assets/icons/business.svg',
          width: Dimen.bottomNavIconSize,
          height: Dimen.bottomNavIconSize,
          color: index == 1 ? Theme.of(context).primaryColor : Colors.black,
        ),
      ),
      BottomNavigationBarItem(
        title: SizedBox.shrink(),
        icon: SvgWidget(
          assetPath: 'assets/icons/technology.svg',
          width: Dimen.bottomNavIconSize,
          height: Dimen.bottomNavIconSize,
          color: index == 2 ? Theme.of(context).primaryColor : Colors.black,
        ),
      )
    ];
  }

  void _changeTitle(int index) {
    switch (index) {
      case 0:
        {
          title = general;
        }
        break;
      case 1:
        {
          title = business;
        }
        break;
      case 2:
        {
          title = technology;
        }
        break;
    }
  }
}
