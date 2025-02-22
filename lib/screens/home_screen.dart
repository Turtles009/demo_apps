import 'package:demo_app/bloc/theme_bloc/theme_bloc.dart';
import 'package:demo_app/bloc/theme_bloc/theme_state.dart';
import 'package:demo_app/screens/employee_list_screen.dart';
import 'package:demo_app/widgets/app_drawer.dart';
import 'package:demo_app/widgets/body_container.dart';
import 'package:demo_app/widgets/home_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/app_bar_icon.dart';
import '../widgets/home_card.dart';
import '../model/card_data.dart';
import '../model/tile_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<CardData> _cards;

  final List<TileData> _tiles = [
    TileData(
      tileName: 'Client Management',
      tileColor: Colors.blue,
      tileIcon: const Icon(Icons.person),
    ),
    TileData(
      tileName: 'NOC/Ex Certificate',
      tileColor: Colors.orange,
      tileIcon: const Icon(Icons.edit_document),
    ),
    TileData(
      tileName: 'Notice Board',
      tileColor: Colors.green,
      tileIcon: const Icon(Icons.bookmark_added_rounded),
    ),
    TileData(
      tileName: 'Award',
      tileColor: Colors.purple,
      tileIcon: const Icon(Icons.star_outline),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cards = [
      CardData(
        cardName: 'Employee',
        cardColor: Colors.purple,
        callBackHandler: () => pushScreen(
          // const EmployeeDetailsScreen(
          //   employeeName: 'Shaidul Islam',
          //   employeeDesignation: 'Designer',
          // ),
          const EmployeeListScreen(),
        ),
      ),
      CardData(
        cardName: 'Expense',
        cardColor: const Color.fromARGB(255, 231, 84, 133),
      ),
      CardData(
        cardName: 'Payroll',
        cardColor: Colors.blue,
      ),
      CardData(
        cardName: 'File',
        cardColor: Colors.green,
      ),
    ];
  }

  void pushScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: const Color(0xff5e7cec),
      appBar: AppBar(
        clipBehavior: Clip.none,
        titleTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        // iconTheme: const IconThemeData(color: Colors.white),
        // forceMaterialTransparency: true,
        // backgroundColor: const Color(0xff5e7cec),
        leading: AppBarIcon(
          isBadge: false,
          onPressedHandler: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu_outlined),
        ),
        title: const Text(
          'HRM & \nPayroll Management',
          softWrap: true,
        ),
        actions: [
          AppBarIcon(
            onPressedHandler: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BodyContainer(
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              childAspectRatio: 1.1,
              crossAxisCount: 2,
              padding: const EdgeInsets.all(22),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: _cards
                  .map(
                    (card) => HomeCard(
                      borderColor: card.cardColor,
                      title: card.cardName,
                      onTapHandler: card.callBackHandler,
                    ),
                  )
                  .toList(),
            ),
            // const SizedBox(height: 10),
            Expanded(
              child: Material(
                elevation: 12,
                borderRadius: BorderRadius.circular(24),
                child: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                  return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        // border: Border(
                        //   top: BorderSide(
                        //     color: Colors.black12,
                        //   ),
                        //   left: BorderSide(
                        //     color: Colors.black12,
                        //   ),
                        //   right: BorderSide(
                        //     color: Colors.black12,
                        //   ),
                        // ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        color: state.themeMode == ThemeMode.dark
                            ? Colors.grey.shade700
                            : const Color.fromARGB(255, 250, 250, 250),
                      ),
                      child: ListView.separated(
                          itemBuilder: (context, index) => HomeTile(
                                title: _tiles[index].tileName,
                                tileColor: _tiles[index].tileColor,
                                icon: _tiles[index].tileIcon,
                              ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: _tiles.length));
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
