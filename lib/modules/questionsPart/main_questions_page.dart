import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemo_cell/modules/questionsPart/myQuestionsPage.dart';

import '../../shared/components/components.dart';
import 'add_questions_screen.dart';

class MainQuestionsScreen extends StatelessWidget {
  const MainQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 5, bottom: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      color: mainColor,
                      size: 32,
                    ),
                  ),
                  Text(
                    'Questions part',
                    style: GoogleFonts.bangers(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: mainColor,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 12,
                      child: Text(
                        'Add question',
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddQuestionsScreen()));
                      },
                          icon: Icon(Icons.chevron_right,size: 32,color: Colors.white,)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: mainColor,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 12,
                      child: Text(
                        'My question',
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyQuestionsScreen()));
                      },
                          icon: Icon(Icons.chevron_right,size: 32,color: Colors.white,)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
