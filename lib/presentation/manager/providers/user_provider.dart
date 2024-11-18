import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/use_cases/get_user_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserProvider extends ChangeNotifier {
  UserEntity? user;
  User? firebaseUser;
  final GetUserUseCase getUserUseCase;
  bool isInitializing = true; // Flag to track initialization

  UserProvider({required this.getUserUseCase}) {
    // Listen to authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((user) {
      firebaseUser = user;
      if (firebaseUser != null) {
        initUser();
      } else {
        user = null; // Reset user if no Firebase user
      }
      isInitializing = false; // Firebase initialization done
      notifyListeners(); // Notify listeners that initialization is complete
    });
  }

  void initUser() async {
    if (firebaseUser != null) {
      user = await getUserUseCase.call(firebaseUser?.uid ?? '');
      notifyListeners(); // Notify listeners after user info is fetched
    }
  }

  // Function to log out the user
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    firebaseUser = null;
    user = null; // Clear user data
    notifyListeners();
  }
}
