import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(LoginLoading());

        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailure(errMessage: 'User not found'));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailure(errMessage: 'Wrong Password'));
          }
        } catch (e) {
          emit(LoginFailure(errMessage: 'Something went wrong'));
        }
      },
    );

    on<RegisterEvent>(
      (event, emit) async {
        emit(RegisterLoading());

        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(
                errMessage: 'The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(
                errMessage: 'The account already exists for that email.'));
          }
        } catch (e) {
          emit(RegisterFailure(errMessage: 'Something went wrong: $e'));
        }
      },
    );
  }
}
