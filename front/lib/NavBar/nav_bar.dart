import 'dart:io';

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;


  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
            bottom: Radius.circular(0),
          ),
          child: Container(
            width: 390,
            height: 80,
            color: Colors.black.withOpacity(0.20000000298023224),
            child: Row(
              children: [
                navItem(
                  Icons.home_outlined,
                  pageIndex == 0,
                  onTap: () => onTap(0),
                  label: 'home',


                ),
                navItem(
                  Icons.directions_car,
                  pageIndex == 1,
                  onTap: () => onTap(1),
                  label: 'addtrajet',
                ),
                const SizedBox(width: 80),
                navItem(
                  Icons.group,
                  pageIndex == 2,
                  onTap: () => onTap(2),
                  label: 'groupe',
                ),
                navItem(
                  Icons.settings,
                  pageIndex == 3,
                  onTap: () => onTap(3),
                  label: 'parametres',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap, required String label}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: selected ? Color(0xFF00AA9B) : Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}
