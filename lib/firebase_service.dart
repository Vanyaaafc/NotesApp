import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseService _singleton = FirebaseService._internal();

  factory FirebaseService() => _singleton;

  FirebaseService._internal();

  final auth = FirebaseAuth.instance;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  bool isUserLoggedIn() {
    return auth.currentUser != null;
  }

  // Future<void> tokenListener() async {
  //   final storage = await SharedPreferences.getInstance();
  //   try {
  //     auth.idTokenChanges().listen((user) async {
  //       if (user != null) {
  //         final userToken = await user.getIdToken();
  //         storage.setString(kToken, userToken!);
  //       } else {
  //         storage.remove(kToken);
  //       }
  //     });
  //   } catch (e) {
  //     log('[AuthBloc][_tokenListener] $e');
  //   }
  // }
}