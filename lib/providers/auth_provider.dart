import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/user.dart';
import '../data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Auth state as ChangeNotifier so GoRouter can use it as refreshListenable.
class AuthNotifier extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  bool get isLoggedIn => _user != null;

  final AuthRepository _repo = AuthRepository();

  Future<void> login({required String email, required String password}) async {
    _user = await _repo.login(email: email, password: password);
    notifyListeners();
  }

  Future<void> logout() async {
    await _repo.logout();
    _user = null;
    notifyListeners();
  }
}

final authNotifierProvider =
    ChangeNotifierProvider<AuthNotifier>((ref) => AuthNotifier());

/// Current user; null when logged out.
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authNotifierProvider).user;
});

/// True when logged in. Used for router redirect.
final authStateProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isLoggedIn;
});
