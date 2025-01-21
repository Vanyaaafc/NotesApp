import 'package:get_it/get_it.dart';
import 'package:notes_app/features/auth_screen/domain/auth_bloc.dart';
import 'package:notes_app/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final g = GetIt.asNewInstance();

Future<void> setup() async {
 g.registerSingleton<FirebaseService>(FirebaseService());

 final sharedPreferences = await _getStorage();
 g.registerSingleton<SharedPreferences>(sharedPreferences);

 g.registerSingleton<AuthBloc>(AuthBloc(g.get<FirebaseService>(), g.get<SharedPreferences>()));
}

Future<SharedPreferences> _getStorage() async =>
    SharedPreferences.getInstance();