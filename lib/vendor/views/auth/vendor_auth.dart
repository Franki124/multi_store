import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfire_ui/auth.dart';

import '../screens/landing_screen.dart';

class VendorAuthScreen extends StatelessWidget {
  const VendorAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return const SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(clientId: "1:247416658912:android:b487b4385b999decbce985"),
                PhoneProviderConfiguration(),
              ]
          );
        }

        // Render your application if authenticated
        return LandingScreen();
      },
    );
  }
}
