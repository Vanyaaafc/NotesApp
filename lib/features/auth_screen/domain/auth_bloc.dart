import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._firebaseService, this._sharedPreferences) : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) {});
    on<AuthInitialEvent>(_init);
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<ShowSignUpScreenEvent>((event, emit) {
      emit(ShowSignUpScreenState());
    });
    on<ShowAuthScreenEvent>((event, emit) {
      emit(ShowAuthScreenState());
    });
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _init(AuthInitialEvent event, Emitter<AuthState> emit) async {
    if (_firebaseService.currentUser != null) {
      emit(AuthLoadedState());
    } else {
      emit(AuthInitialState());
    }
  }

  final FirebaseService _firebaseService;
  final SharedPreferences _sharedPreferences;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _onRegister(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(SignUpLoadingState());
    try {
      await auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(SignUpLoadedState());
    } on FirebaseAuthException catch (e) {
      emit(SignUpErrorState(error: e.message ?? 'Error during registration'));
    } catch (e) {
      emit(SignUpErrorState(error: e.toString()));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      UserCredential userCredential = await _firebaseService.auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      String? token = await userCredential.user?.getIdToken();
      if (token != null) {
        print("User token: $token");
      } else {
        print("Failed to retrieve user token.");
      }

      emit(AuthLoadedState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthErrorState(error: 'No user found Email'));
      } else if (e.code == 'wrong-password') {
        emit(AuthErrorState(error: 'Wrong password provided'));
      } else {
        emit(AuthErrorState(error: 'Unexpected occurred'));
      }
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await _firebaseService.auth.signOut();
      _sharedPreferences.clear();
      emit(AuthLogoutState());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
