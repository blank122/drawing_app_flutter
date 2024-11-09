import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuildDrawer extends StatefulWidget {
  const BuildDrawer({super.key});

  @override
  State<BuildDrawer> createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
              child: Image.asset('assets/images/logo.png'), //same here
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Text(
              'Northern Iloilo State University', //dapat naa niy variable
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
