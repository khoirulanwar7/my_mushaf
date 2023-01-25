import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:holyquran_app/globals.dart';
import 'package:holyquran_app/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: primary,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset('assets/images/splash-image.png'),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Jika kamu menjadikan Al-Qur'an sebagai panduan, maka kamu tidak akan pernah kehilangan arah.",
                  style: GoogleFonts.poppins(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 14)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                    width: 200,
                    height: 45,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xffEAB814),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: Text('Mulai Membaca',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))))),
              ],
            ),
          )),
    );
  }
}
