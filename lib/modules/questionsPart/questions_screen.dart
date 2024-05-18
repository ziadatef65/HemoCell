import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemo_cell/modules/questionsPart/cubit/cubit.dart';
import 'package:hemo_cell/modules/questionsPart/cubit/states.dart';
import 'package:intl/intl.dart';

import '../../shared/components/components.dart';

class QuestionsPage extends StatelessWidget {

  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddQuestionCubit,AddQuestionsStates>(
      listener: (context,state){},
      builder: (context,state) {
var cubit = AddQuestionCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('questions').get(),
              builder: (context, snapshot) {

    if (!snapshot.hasData) {
    // Handle the case where data is not available yet.
    return const Center(
    child: CircularProgressIndicator(
    color: Colors.black,
    ),
    );
    } else if (snapshot.hasError) {
    // Handle the case where an error occurred.
    return Text('Error: ${snapshot.error}');
    }
    if (snapshot.connectionState ==
    ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(
    color: Colors.black,
    ));
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else {
      List<List<Map<String, dynamic>>> allQuestions = [];

      snapshot.data!.docs.forEach((doc) {
        List<Map<String, dynamic>> questions = List.from(doc['questions']);
        allQuestions.add(questions);
      });
      List<Map<String, dynamic>> combinedQuestions;
      if(cubit.indexOfTypesDiseases == 1) {
        combinedQuestions = allQuestions.expand((
            questions) => questions)
            .where((d) => d['isAccepted'] == true )
            .toList();
      }else if(cubit.indexOfTypesDiseases == 2){
      combinedQuestions = allQuestions.expand((
            questions) => questions)
            .where((d) => d['isAccepted'] == true &&d['category'] == 'Infectious diseases')
            .toList();
      }else if(cubit.indexOfTypesDiseases == 3){
      combinedQuestions = allQuestions.expand((
            questions) => questions)
          .where((d) => d['isAccepted'] == true &&d['category'] == 'Chronic diseases')
            .toList();
      }else {
        combinedQuestions    = allQuestions.expand((
            questions) => questions)
            .where((d) => d['isAccepted'] == true &&d['category'] == 'Anemia')
            .toList();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Questions part',
              style: GoogleFonts.bangers(
                fontSize: 32,
                color: mainColor,
              ),
            ),
          ),
          if(cubit.indexOfTypesDiseases == 1)
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child:
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo1();
                    },
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'General',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo2();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Infectious diseases',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo3();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Chronic diseases',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo4();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Anemia',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          if(cubit.indexOfTypesDiseases == 2)
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child:
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo1();
                    },
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'General',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo2();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Infectious diseases',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo3();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Chronic diseases',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo4();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Anemia',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          if(cubit.indexOfTypesDiseases == 3)
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child:
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo1();
                    },
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'General',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo2();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Infectious diseases',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo3();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Chronic diseases',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo4();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Anemia',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          if(cubit.indexOfTypesDiseases == 4)
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child:
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo1();
                    },
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'General',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo2();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Infectious diseases',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo3();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Chronic diseases',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      cubit.ChangeIndexOfTypesDiseasesTo4();
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        child: Center(
                          child: Text(
                            'Anemia',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(

                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: mainColor,
                ),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    String formatTimestamp(Timestamp timestamp) {
                      DateTime dateTime = timestamp.toDate().toLocal();
                      var formatter =
                      DateFormat('MMMM dd, yyyy h:mm a');

                      return formatter.format(dateTime);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20,right: 20),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   combinedQuestions[index]['name'].toString().toUpperCase(),
                                   style: GoogleFonts.lato(
                                     fontSize:12,
                                     fontWeight:FontWeight.bold,

                                   ),
                                 ),
                                 Text(
                                     formatTimestamp( combinedQuestions[index]['timestampOfBegin']),
                                   style: GoogleFonts.lato(
                                     fontSize:8,
                                     fontWeight:FontWeight.bold,
                                     color:mainColor,

                                   ),
                                 ),
                                 SizedBox(height: 5,),
                                 Text(
                                     combinedQuestions[index]['question'],
                                   style: GoogleFonts.lato(
                                     fontSize:16,
                                     fontWeight:FontWeight.bold,
                                     color:Colors.black,

                                   ),
                                 ),
                                 SizedBox(height: 3,),

                                 Text(
                                     'Ans: ${combinedQuestions[index]['answer']}',
                                   style: GoogleFonts.podkova(
                                     fontSize:12,
                                     fontWeight:FontWeight.w500,
                                     color:Colors.black,

                                   ),
                                 ),



                               ],
                             ),
                           ),
                            if( combinedQuestions[index]['category']== 'Infectious diseases')
                              Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                                color: Colors.amber,
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                    Text('Infectious diseases',
                                    style: GoogleFonts.lato(
                                      fontSize:10,
                                      color:Colors.black,
                                      fontWeight:FontWeight.bold,
                                    ),

                                    ),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                ),
                                                          ),
                            if( combinedQuestions[index]['category']== 'Chronic diseases')
                              Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                                color: Colors.teal,
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                    Text('Chronic diseases',
                                    style: GoogleFonts.lato(
                                      fontSize:10,
                                      color:Colors.black,
                                      fontWeight:FontWeight.bold,
                                    ),

                                    ),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                ),
                                                          ),
                            if( combinedQuestions[index]['category']== 'Anemia')
                              Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                                color: Colors.blue,
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                    Text('Anemia',
                                    style: GoogleFonts.lato(
                                      fontSize:10,
                                      color:Colors.black,
                                      fontWeight:FontWeight.bold,
                                    ),

                                    ),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                ),
                                                          ),


                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: combinedQuestions.length,
                ),
              ),
            ),
          )
        ],
      );
    }
              }
            ),
          ),
        );
      }
    );
  }
}
