import 'package:azan_reminder/core/common/error/exception.dart';
import 'package:azan_reminder/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  User? get currentUser;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
  Future<void> storeUserData({required UserModel user});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AuthRemoteDataSourceImpl(this.firestore, this.auth);

  @override
  User? get currentUser => auth.currentUser;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      final userData = await getCurrentUserData();
      if (userData == null) {
        throw const ServerException('User data not found!');
      }
      return userData;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        e.message ?? 'An unknown error occurred. Please try again.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      final user = UserModel(id: response.user!.uid, name: name, email: email);
      await storeUserData(user: user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        e.message ?? 'An unknown error occurred. Please try again.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUser != null) {
        final userData =
            await firestore.collection('users').doc(currentUser!.uid).get();
        if (userData.exists) {
          return UserModel.fromJson(userData.data()!);
        }
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> storeUserData({required UserModel user}) async {
    try {
      await firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
