import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'add_questions_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class MyQuestionsScreen extends StatelessWidget {
  const MyQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddQuestionCubit.get(context);
    return BlocConsumer<AddQuestionCubit, AddQuestionsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(top: 20, left: 5, bottom: 20),
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
                      'My Question',
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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          cubit.ChangeOfIndexOfPages1();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: cubit.indexOfChangePages == 1
                                ? Colors.black
                                : mainColor,
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Accepted questions',
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight:FontWeight.bold,
                                    fontSize:16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          cubit.ChangeOfIndexOfPages2();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: cubit.indexOfChangePages == 2
                                ? Colors.black
                                : mainColor,
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Refused questions',
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight:FontWeight.bold,
                                    fontSize:16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if(cubit.indexOfChangePages == 1)
                Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    var dataLength = snapshot.data
                        ?.data()?['listOfQuestions']
                        ?.where((d) => d['isAccepted'] == true)
                        .length;
                    var d = snapshot.data
                        ?.data()?['listOfQuestions']
                        ?.where((d) => d['isAccepted'] == true)
                        .toList();

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
                    }
                    else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');

                    }
                    else if(dataLength == null || dataLength ==0 ||d.isEmpty){
                      return Center(
                        child: Text(
                          'No questions accepted yet',
                          style: GoogleFonts.lato(
                              fontWeight:FontWeight.bold,
                              fontSize:24,
                              color:mainColor
                          ),
                        ),
                      );

                    }
                    else {

                 return Padding(
                   padding: const EdgeInsets.all(20),
                   child: Container(

                     width: double.infinity,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: mainColor,
                     ),
                     child: ListView.separated(
                       physics: const BouncingScrollPhysics(),
                       itemBuilder: (context, index) {

                         String formatTimestamp(Timestamp timestamp) {
                           DateTime dateTime = timestamp.toDate().toLocal();
                           var formatter =
                           DateFormat('MMMM dd, yyyy h:mm a');

                           return formatter.format(dateTime);
                         }
                         return Padding(
                           padding: const EdgeInsets.only(left: 20,right:20 ,bottom: 0),
                           child: Column(
                             children: [
                               const SizedBox(height: 20,),
                               Container(
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
                                             d[index]['name'].toString().toUpperCase(),
                                             style: GoogleFonts.lato(
                                               fontSize:12,
                                               fontWeight:FontWeight.bold,

                                             ),
                                           ),
                                           Text(
                                             formatTimestamp( d[index]['timestampOfBegin']),
                                             style: GoogleFonts.lato(
                                               fontSize:8,
                                               fontWeight:FontWeight.bold,
                                               color:mainColor,

                                             ),
                                           ),
                                           const SizedBox(height: 5,),
                                           Text(
                                             d[index]['question'],
                                             style: GoogleFonts.lato(
                                               fontSize:16,
                                               fontWeight:FontWeight.bold,
                                               color:Colors.black,

                                             ),
                                           ),
                                           const SizedBox(height: 3,),

                                           Text(
                                             'Ans: ${d[index]['answer']}',
                                             style: GoogleFonts.podkova(
                                               fontSize:12,
                                               fontWeight:FontWeight.w500,
                                               color:Colors.black,

                                             ),
                                           ),



                                         ],
                                       ),
                                     ),
                                     if( d[index]['category']== 'Infectious diseases')
                                       Container(
                                         width: double.infinity,
                                         decoration: const BoxDecoration(
                                           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                                           color: Colors.amber,
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.all(5),
                                           child: Row(
                                             children: [
                                               const Spacer(),
                                               Text('Infectious diseases',
                                                 style: GoogleFonts.lato(
                                                   fontSize:10,
                                                   color:Colors.black,
                                                   fontWeight:FontWeight.bold,
                                                 ),

                                               ),
                                               const SizedBox(width: 10,),
                                             ],
                                           ),
                                         ),
                                       ),
                                     if( d[index]['category']== 'Chronic diseases')
                                       Container(
                                         width: double.infinity,
                                         decoration: const BoxDecoration(
                                           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                                           color: Colors.teal,
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.all(5),
                                           child: Row(
                                             children: [
                                               const Spacer(),
                                               Text('Chronic diseases',
                                                 style: GoogleFonts.lato(
                                                   fontSize:10,
                                                   color:Colors.black,
                                                   fontWeight:FontWeight.bold,
                                                 ),

                                               ),
                                               const SizedBox(width: 10,),
                                             ],
                                           ),
                                         ),
                                       ),
                                     if( d[index]['category']== 'Anemia')
                                       Container(
                                         width: double.infinity,
                                         decoration: const BoxDecoration(
                                           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                                           color: Colors.blue,
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.all(5),
                                           child: Row(
                                             children: [
                                               const Spacer(),
                                               Text('Anemia',
                                                 style: GoogleFonts.lato(
                                                   fontSize:10,
                                                   color:Colors.black,
                                                   fontWeight:FontWeight.bold,
                                                 ),

                                               ),
                                               const SizedBox(width: 10,),
                                             ],
                                           ),
                                         ),
                                       ),
                                   ],
                                 ),
                               ),
                               const SizedBox(height: 20,),

                             ],
                           ),
                         );
                       },
                       itemCount: dataLength,
                       separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 0,);  },
                     ),
                   ),
                 );

                    }
                  },
                ),
              ),
              if(cubit.indexOfChangePages == 2)
                Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    var dataLength = snapshot.data
                        ?.data()?['listOfQuestions']
                        ?.where((d) => d['isAccepted'] == false)
                        .length;
                    var d = snapshot.data
                        ?.data()?['listOfQuestions']
                        ?.where((d) => d['isAccepted'] == false)
                        .toList();
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
                    }
                    else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    else if(dataLength == null || dataLength ==0 ||d.isEmpty){
                      return Center(
                        child: Text(
                          'No questions refused yet',
                          style: GoogleFonts.lato(
                              fontWeight:FontWeight.bold,
                              fontSize:24,
                              color:mainColor
                          ),
                        ),
                      );

                    }
                    else {
                 return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(

                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: mainColor,
                            ),
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                String formatTimestamp(Timestamp timestamp) {
                                  DateTime dateTime = timestamp.toDate().toLocal();
                                  var formatter =
                                  DateFormat('MMMM dd, yyyy h:mm a');

                                  return formatter.format(dateTime);
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20,bottom: 20,top: 20),
                                  child: Container(
                                    width: double.infinity,

                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            d[index]['name']
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              color: mainColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            d[index]['userId']
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.clock,
                                                color: mainColor,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                formatTimestamp(d[index]
                                                ['timestampOfBegin']),
                                                style: GoogleFonts.lato(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: mainColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            d[index]['question'],
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 2,
                                            color: mainColor,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Cause of refused: ${d[index]['refuseMessages']}',
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),



                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: mainColor
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10,top: 2,bottom:2,right: 10),
                                                          child: Text('Rejected',
                                                            style: GoogleFonts.lato(
                                                              fontWeight:FontWeight.bold,
                                                              color:Colors.white,
                                                              fontSize:12,
                                                            ),
                                                          ),
                                                        ),



                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount:dataLength, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 0,);  },
                            ),
                          ),
                        ),
                      );

                    }
                  },
                ),
              ),

            ],
          ),

        );
      },
    );
  }
}
