import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemo_cell/layout/hemo_cell_layout.dart';
import 'package:hemo_cell/shared/components/constants.dart';

import '../../shared/components/components.dart';
import '../login/login_screen.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>userId !=null ? HemoCellLayout() :LoginScreen()));

    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'Life ',

              style: GoogleFonts.bangers(
                fontSize:64,
                fontWeight:FontWeight.bold,
                color:Colors.black
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120,left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Saver',

                    style: GoogleFonts.bangers(
                      fontSize:54,
                      fontWeight:FontWeight.bold,
                      color:mainColor,
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png')
                        )
                    ),
                  )

                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}

