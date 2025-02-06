import 'package:auto_route/auto_route.dart';
import 'package:notes_app/routing/app_router.gr.dart';
import 'package:notes_app/routing/routes.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AppRoute.page, path: '/', children: [
      AutoRoute(page: AuthRoute.page, path: Routes.auth, initial: true),
      
      ///to bottomBar
      AutoRoute(page: MainRoute.page, path: Routes.main)
    ])
  ];
}