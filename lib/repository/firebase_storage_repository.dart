import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Expose the FirebaseStorageRepository to access them globaly
final Provider<FirebaseStorageRepository> firebaseStorageRepositoryProvider =
    Provider<FirebaseStorageRepository>(
  (ProviderRef<FirebaseStorageRepository> ref) => FirebaseStorageRepository(),
);

/// Contains the functions to store and retrieve files from firebase cloud storage
class FirebaseStorageRepository {
  final FirebaseStorage _storageRef = FirebaseStorage.instance;

  /// Used to upload a file on a firebase cloud storage bucket
  Future<dynamic> uploadFile({required String path, required File file}) async {
    try {
      final Reference ref = _storageRef.ref('path${file.path.split('/').last}');
      await ref.putFile(file);
      final String url = await ref.getDownloadURL();

      return url;
    } catch (e) {
      log('Error upload file $e');
      return false;
    }
  }
}
