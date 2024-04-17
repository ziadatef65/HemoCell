import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/components.dart';

class SpecificPlaceScreen extends StatelessWidget {
  const SpecificPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 5),
                child: Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          Navigator.pop(context);
                        }
                        , icon: Icon(Icons.chevron_left,size: 32,color: mainColor,)),
                    Text('Dar Al Fouad Hospital',
                      style: GoogleFonts.bangers(
                        fontSize:24,
                        color:mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 230,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,

                    image: NetworkImage('https://lh3.googleusercontent.com/p/AF1QipN9nitsCYfWhCEcnqKqIapGM6vwRMLDw4ZggvMs=s680-w680-h510')
                  ),

                ),
                child: Stack(

                  children: [
                    Positioned(
                      right:10,
                      bottom: 10,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: mainColor,width: 2),
                            shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(

                                    image: AssetImage('assets/images/logo.png')
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color:Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Details :',
                                style: GoogleFonts.bangers(
                                  fontSize:24,
                                  fontWeight:FontWeight.bold,
                                  color:mainColor,
                                ),
                              ),
                              Text(
                                  'Dar Al Fouad Hospital is a leading private hospital in Cairo, offering a wide range of medical services including surgery, cardiology, oncology, and more. The hospital is equipped with state-of-the-art facilities and staffed by experienced medical professionals',
                                style: GoogleFonts.lato(
                                  fontSize:18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Hours of Work :',
                                style: GoogleFonts.bangers(
                                  fontSize:24,
                                  fontWeight:FontWeight.bold,
                                  color:mainColor,
                                ),
                              ),
                              Text(
                                  'Open 24 hours, 7 days a week',
                                style: GoogleFonts.lato(
                                  fontSize:18,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
