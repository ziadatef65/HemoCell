import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemo_cell/admin/cubit/cubit.dart';
import 'package:hemo_cell/admin/cubit/states.dart';
import 'package:hemo_cell/admin/questions/specificQuestionPage.dart';
import 'package:hemo_cell/shared/components/components.dart';

class MainQuestionsDashboardScreen extends StatelessWidget {
  const MainQuestionsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          }
                          ,
                          icon: Icon(
                            Icons.chevron_left, size: 32, color: mainColor,)),
                      Text(
                        'Questions part',
                        style: GoogleFonts.bangers(
                            fontSize: 24,
                            color: mainColor
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder(
                stream: FirebaseFirestore.instance.collection('questions').snapshots()
                , builder: (context,snapshot){
                  var dataLength = snapshot.data?.docs.length;
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context,index){
                        var nameOfDocs = snapshot.data?.docs[index].id;
                        return Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: mainColor,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top:10,
                                  left: 20,
                                  child: Text(
                                    nameOfDocs.toString(),
                                    style: GoogleFonts.bangers(
                                      color:Colors.white,
                                      fontSize:24,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: IconButton(
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SpecificQuestionsPage(nameOfDocs)));
                                  }
                                  , icon: Icon(Icons.chevron_right,size: 32,color: Colors.white,)),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: dataLength,
                    ),
                  );
                }
                ),
              ],
            ),
          ),
        );
      }

}
