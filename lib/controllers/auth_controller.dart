import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:collectly/firebase/references.dart';
import 'package:collectly/screens/screens.dart'
    show HomeScreen, AppIntroductionScreen, LoginScreen;
import 'package:collectly/utils/utils.dart';
import 'package:collectly/widgets/widgets.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  // Check whether the user is authenticated or not
  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // waiting in splash
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  // Initiate the sign in process with google
  Future<void> siginInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _gAuthentication = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _gAuthentication.idToken,
          accessToken: _gAuthentication.accessToken,
        );
        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHome();
      }
    } on Exception catch (error) {
      AppLogger.e(error);
    }
  }

  // Sign out from the application
  Future<void> signOut() async {
    AppLogger.d("Sign out");
    try {
      await _auth.signOut();
      navigateToIntroduction();
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  // Save the user after google to the system
  Future<void> saveUser(GoogleSignInAccount account) async {
    userFR.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl,
    });
  }

  // Get the current user details
  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  // Check the login status of the user
  bool isLogedIn() {
    return _auth.currentUser != null;
  }

  void navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void navigateToLogin() {
    Get.toNamed(LoginScreen.routeName);
  }

  void navigateToIntroduction() {
    Get.offAllNamed(AppIntroductionScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.quizStartDialog(onTap: () {
        Get.back();
        navigateToLogin();
      }),
      barrierDismissible: false,
    );
  }
}
