import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:webcicle/ArtigosPage.dart';
import 'package:webcicle/PedidosPage.dart';
import 'package:webcicle/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required String uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: AppColors.green,
              labelColor: AppColors.green,
              unselectedLabelColor: AppColors.gray,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Artigos',
                    style: GoogleFonts.inter(
                      fontSize: 8.sp,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Pedidos',
                    style: GoogleFonts.inter(
                      fontSize: 8.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ArtigosPage(),
              PedidosPage(),
            ],
          ),
        ),
      );
    });
  }
}
