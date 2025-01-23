import 'package:expense_tracker_web/util/google_credentials.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:googleapis/sheets/v4.dart' as sheets;



class GoogleSignInHelper {
  static final List<String> scopes = [
    'email',
    drive.DriveApi.driveFileScope,
  ];

  static final GoogleSignIn googleSignIn =
      GoogleSignIn(clientId: clientId, scopes: scopes);

  static GoogleSignInAccount? googleAccount;

  static void setAccount(GoogleSignInAccount account) {
    googleAccount = account;

  }

  static Future<GoogleSignInAccount?> signIn() {
    return googleSignIn.signIn();
    // // Try silent sign in first
    // return googleSignIn.signInSilently().then((account) {
    //   if (account != null) {
    //     return account;
    //   }
    //   // If silent sign in fails, use manual sign in
    //   return googleSignIn.signIn();
    // });
  }

  static Future<GoogleSignInAccount?> signOut() {
    return googleSignIn.signOut();
  }
}
