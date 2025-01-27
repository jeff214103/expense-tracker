import 'dart:async';
import 'dart:convert';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:expense_tracker_web/util/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class GoogleDriveHelper {
  static Future<Map<String, dynamic>> upload(
      {required Uint8List fileData, required String filename}) async {
    // Get authenticated client
    final authClient =
        (await GoogleSignInHelper.googleSignIn.authenticatedClient())!;
    final drive.DriveApi driveApi = drive.DriveApi(authClient);

    // Check if Expense Receipt folder exists
    final folderId = await checkAndCreateFolder(driveApi, "Expense Receipt");

    // Create media object
    final media = drive.Media(
        Stream.fromIterable(
          fileData.map((e) => [e]),
        ),
        fileData.lengthInBytes);

    // Create file metadata
    final fileToUpload = drive.File()
      ..name = filename
      ..parents = [folderId];

    // Upload file
    final result =
        await driveApi.files.create(fileToUpload, uploadMedia: media);

    return result.toJson();
  }

  static Future<String> checkAndCreateFolder(
      driveApi, String folderName) async {
    // Query folders with matching name
    final query = "name = '$folderName'";
    final folders = await driveApi.files.list(q: query);

    // Check if folder exists
    if (folders.files?.isNotEmpty == true) {
      return folders.files!.first.id!; // Return existing folder ID
    } else {
      // Create folder
      final newFolder = drive.File();
      newFolder.mimeType = "application/vnd.google-apps.folder";
      newFolder.name = folderName;
      final createdFolder = await driveApi.files.create(newFolder);
      return createdFolder.id!; // Return newly created folder ID
    }
  }

  static Future<String?> findFileIdByName(String filename) async {
    try {
      // Get authenticated client
      final authClient =
          (await GoogleSignInHelper.googleSignIn.authenticatedClient())!;
      final drive.DriveApi driveApi = drive.DriveApi(authClient);
      
      // First, get the Expense Receipt folder ID
      final folderId = await checkAndCreateFolder(driveApi, "Expense Receipt");

      // Query for the file within the Expense Receipt folder
      final query = "'$folderId' in parents and name = '$filename'";
      final fileList = await driveApi.files.list(q: query);

      // Return the first matching file's ID, if any
      return fileList.files?.isNotEmpty == true
          ? fileList.files!.first.id
          : null;
    } catch (e) {
      if (kDebugMode) {
        print('Error finding file: $e');
      }
      return null;
    }
  }

  static Future<Uint8List?> downloadFile(String filename) async {
    try {
      // Find the file ID first
      final fileId = await findFileIdByName(filename);

      if (fileId == null) {
        if (kDebugMode) {
          print('No file found with name: $filename');
        }
        return null;
      }

      // Get authenticated client
      final authClient =
          (await GoogleSignInHelper.googleSignIn.authenticatedClient())!;
      final drive.DriveApi driveApi = drive.DriveApi(authClient);

      // Download file media
      final media = await driveApi.files.get(fileId,
          downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

      // Convert stream to Uint8List
      final completer = Completer<Uint8List>();
      final sink = ByteConversionSink.withCallback((bytes) {
        completer.complete(Uint8List.fromList(bytes));
      });

      media.stream.listen(
        sink.add,
        onDone: sink.close,
        onError: completer.completeError,
        cancelOnError: true,
      );

      return completer.future;
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }

  static Future<bool> removeFileWithRollback({
    required String filename,
    required Future<bool> Function() additionalCleanupAction,
  }) async {
    try {
      // Get authenticated client
      final authClient =
          (await GoogleSignInHelper.googleSignIn.authenticatedClient())!;
      final driveApi = drive.DriveApi(authClient);
      
      // Find the file ID
      final fileId = await findFileIdByName(filename);
      
      if (fileId == null) {
        if (kDebugMode) {
          print('No file found with name: $filename');
        }
        return false;
      }

      // Perform concurrent operations
      final List<dynamic> results = await Future.wait([
        // Delete file from Google Drive
        driveApi.files.delete(fileId),
        
        // Run additional cleanup action (e.g., clearing sheet filename)
        additionalCleanupAction(),
      ]);

      return results[1] == true;
    } catch (e) {
      if (kDebugMode) {
        print('Error removing file $filename: $e');
      }
      return false;
    }
  }
}
