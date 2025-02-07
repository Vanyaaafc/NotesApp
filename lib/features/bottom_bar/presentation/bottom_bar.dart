import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/features/bottom_bar/widgets/bottom_bar_widget.dart';
import 'package:notes_app/routing/app_router.gr.dart';
import 'package:notes_app/shared/styles/colors.dart';

@RoutePage()
class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AutoTabsScaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          routes: const [
            HomeRoute(),
            FinishedRoute(),
            SearchRoute(),
            SettingsRoute()
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            return BottomBarWidget(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark_added_rounded),
                    label: 'Finished'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings')
              ],
              iconSize: 32,
              selectedItemColor: AppColors.darkPurple,
              unselectedItemColor: Colors.grey,
            );
          },
        ),
        Positioned(
          bottom: 55,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 75,
              height: 75,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.lightPurple, AppColors.darkPurple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: RawMaterialButton(
                shape: const CircleBorder(),
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                  size: 45,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
