import 'package:auto_route/auto_route.dart';
import 'package:notes_app/routing/app_router.gr.dart';
import 'package:notes_app/routing/routes.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AppRoute.page, path: '/', children: [
          AutoRoute(page: AuthRoute.page, path: Routes.auth, initial: true),
          AutoRoute(page: BottomBar.page, path: Routes.bottomBar, children: [
            AutoRoute(page: HomeRoute.page, path: Routes.home),
            AutoRoute(page: FinishedRoute.page, path: Routes.finished),
            AutoRoute(page: SearchRoute.page, path: Routes.search),
            AutoRoute(page: SettingsRoute.page, path: Routes.settings)
          ])
        ])
      ];
}
