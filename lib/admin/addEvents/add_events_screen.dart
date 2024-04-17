import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemo_cell/admin/addEvents/add_event_name.dart';
import 'package:hemo_cell/shared/components/components.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.chevron_left,size: 32,color: mainColor,)),
                    Text(
                      'Our Events',
                      style: GoogleFonts.bangers(
                        color:mainColor,
                        fontSize:24,
                      ),
                    ),
                  ],
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    clipBehavior: Clip.hardEdge,

                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [

                            Colors.black,
                            mainColor
                          ],
                        )
                    ),
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [

                        Positioned(
                          right: 20,
                          bottom: 10,
                          child:  Text(
                            '5',
                            style: GoogleFonts.lato(
                              fontSize:24,
                              color:Colors.white,
                              fontWeight:FontWeight.w900,

                            ),
                          ),
                        ),
                        Positioned(
                          left:20,
                          top: 20,
                          right: 70,
                          child: Text(
                            'We have reached the number of events so far',
                            style: GoogleFonts.lato(
                              fontSize:20,
                              color:Colors.white,
                              fontWeight:FontWeight.bold,

                            ),
                          ),
                        ),
                        Positioned(
                          left:20,
                          bottom: 10,
                          child: Text(
                            'Life Saver',
                            style: GoogleFonts.bangers(
                              fontSize:12,
                              color:Colors.white,
                              fontWeight:FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,

                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 10,
                        child: Text(
                          'Add events',
                          style: GoogleFonts.lato(
                            fontWeight:FontWeight.bold,
                            fontSize:20,
                            color:Colors.white
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: IconButton(
                          icon: const Icon(
                            CupertinoIcons.add_circled,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEventName()));
                          },
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,

                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 10,
                        child: Text(
                          'Our events',
                          style: GoogleFonts.lato(
                            fontWeight:FontWeight.bold,
                            fontSize:20,
                            color:Colors.white
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: IconButton(
                          icon: const Icon(
                            Icons.event,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: (){

                          },
                        )
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
