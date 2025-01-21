import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/firebase_service.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._firebaseService) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {
    on<SignUpInitialEvent>(_init);
    });
    on<RegisterEvent>(_onRegister);
  }

  final FirebaseService _firebaseService;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _init(SignUpInitialEvent event, Emitter<SignUpState> emit) async {
    if (_firebaseService.currentUser != null) {
      emit(SignUpLoadedState());
    } else {
      emit(SignUpInitial());
    }
  }

  Future<void> _onRegister(
      RegisterEvent event, Emitter<SignUpState> emit) async {
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
}
