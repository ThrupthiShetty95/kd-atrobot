import '../models/user.dart';

/// Repository for authentication-related API calls.
class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  }) async {
    // TODO: Replace with real API call
    // final response = await http.post(
    //   Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginPath}'),
    //   body: {'email': email, 'password': password},
    // );
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return User(
      id: '1',
      email: email,
      displayName: email.split('@').first,
    );
  }

  Future<void> logout() async {
    // TODO: Call logout API / clear tokens
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
}
