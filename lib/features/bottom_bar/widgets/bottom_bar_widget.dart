import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notes_app/shared/styles/colors.dart';

class BottomBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double iconSize;
  final double paddingHorizontal;
  final double itemSpacing;

  const BottomBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.selectedItemColor = AppColors.darkPurple,
    this.unselectedItemColor = Colors.grey,
    this.iconSize = 24.0,
    this.paddingHorizontal = 24.0,
    this.itemSpacing = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: paddingHorizontal,
        right: paddingHorizontal,
        bottom: 8 + (Platform.isIOS ? 16 : 0),
        top: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: items.sublist(0, 2).asMap().entries.map((entry) {
              int index = entry.key;
              BottomNavigationBarItem item = entry.value;
              return _buildNavItem(item, index);
            }).toList(),
          ),
          Row(
            children: items.sublist(2).asMap().entries.map((entry) {
              int index = entry.key + 2;
              BottomNavigationBarItem item = entry.value;
              return _buildNavItem(item, index);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BottomNavigationBarItem item, int index) {
    return InkWell(
      onTap: () => onTap(index),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: itemSpacing / 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(
              data: IconThemeData(
                size: iconSize,
                color: currentIndex == index
                    ? selectedItemColor
                    : unselectedItemColor,
              ),
              child: item.icon,
            ),
            if (item.label != null)
              Text(
                item.label!,
                style: TextStyle(
                  color: currentIndex == index
                      ? selectedItemColor
                      : unselectedItemColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}