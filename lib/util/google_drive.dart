import 'dart:async';
import 'dart:typed_data';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:expense_tracker_web/util/google_sign_in.dart';
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
}
