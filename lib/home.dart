import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isBiometric = false;

  Future<bool> authenticatewithbiometric() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    final isBiometricSupported = await localAuthentication.isDeviceSupported();
    final canCheckbiometric = await localAuthentication.canCheckBiometrics;
    bool isAuthenticated = false;
    if (isBiometricSupported && canCheckbiometric) {
      isAuthenticated = await localAuthentication.authenticate(
          localizedReason: 'please complete the Biometric');
    }
    return isAuthenticated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              isBiometric = await authenticatewithbiometric();
              if (isBiometric) {
                log('biometric Supported');
              } else {
                log('biometric Not supported');
              }
            },
            child: const Text('check biometrics')),
      ),
    );
  }
}
