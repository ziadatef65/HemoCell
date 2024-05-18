import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemo_cell/modules/questionsPart/cubit/cubit.dart';
import 'package:hemo_cell/modules/questionsPart/cubit/states.dart';
import 'package:hemo_cell/shared/components/constants.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../shared/components/components.dart';

var questionController = TextEditingController();
var formKey = GlobalKey<FormState>();

class AddQuestionsScreen extends StatelessWidget {
  const AddQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AddQuestionCubit.get(context);

    return BlocConsumer<AddQuestionCubit, AddQuestionsStates>(
      listener: (context, state) {
        if (state is AddQuestionsSuccessfullyState) {
          cubit.isVisible = false;
          showToast(
              text: 'Questions added succefully', state: ToastState.SUCCESS);
          questionController.clear();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: cubit.isVisible == true
              ? Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 50),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  border: Border.all(color: mainColor, width: 3)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 15),
                                    child: Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: mainColor,
                                      ),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          CupertinoIcons.xmark,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          cubit.ChangeIsVisiableToFalse();
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 20, right: 20, top: 30),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Question must not be empty";
                                        }
                                        return null;
                                      },
                                      controller: questionController,
                                      keyboardType: TextInputType.text,
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: mainColor,
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: mainColor,
                                            width: 2,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(1),
                                        hintText: "Question...",
                                        hintStyle: GoogleFonts.lato(
                                          color: Colors.black,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 20, right: 20),
                                    child: Container(
                                      height: 45,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: mainColor,
                                      ),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userId)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            return TextButton(
                                              child: Text(
                                                'Add question',
                                                style: GoogleFonts.bangers(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                              onPressed: () {
                                                if(formKey.currentState!.validate()) {
                                                  cubit.addQuestions(
                                                      snapshot.data
                                                          ?.data()?['name'],
                                                      questionController.text,
                                                      userId);
                                                }
                                              },
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Column(
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
                            'Add Question',
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
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black),
                        child: Container(
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Waiting questions',
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
                      Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            var dataLength = snapshot.data
                                ?.data()?['listOfQuestions']
                                ?.where((d) => d['isAccepted'] == null)
                                .length ;
                            var d = snapshot.data
                                ?.data()?['listOfQuestions']
                                ?.where((d) => d['isAccepted'] == null)
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
                            } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
        }
                              else if(  dataLength == 0 || d ==null ){
                                return Center(
                                  child: Text(
                                    'No questions yet',
                                    style: GoogleFonts.lato(
                                      fontWeight:FontWeight.bold,
                                      fontSize:24,
                                      color:mainColor
                                    ),
                                  ),
                                );

                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {

                                    String formatTimestamp(Timestamp timestamp) {
                                      DateTime dateTime =
                                          timestamp.toDate().toLocal();
                                      var formatter =
                                          DateFormat('MMMM dd, yyyy h:mm a');

                                      return formatter.format(dateTime);
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 25,

                                      ),
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(

                                          clipBehavior: Clip.none,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: mainColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 15,
                                                bottom: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          d[index]['name']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: GoogleFonts.lato(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          formatTimestamp(d[index]
                                                              [
                                                              'timestampOfBegin']),
                                                          style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        PanaraInfoDialog
                                                            .showAnimatedFromBottom(
                                                                context,
                                                                color:
                                                                    Colors.grey,
                                                                message:
                                                                    'Your question has not yet been answered or has been placed in one of the categories. Please wait and a response will come as soon as possible.\n\nThank you for your cooperation with us',
                                                                buttonText: 'Ok',
                                                                onTapDismiss: () {
                                                          Navigator.pop(context);
                                                        },
                                                                panaraDialogType:
                                                                    PanaraDialogType
                                                                        .custom,
                                                                noImage: false);
                                                      },
                                                      child: Container(
                                                        width: 90,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(15),
                                                            color: Colors.white),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  top: 2,
                                                                  bottom: 2,
                                                                  right: 10),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Waiting',
                                                                style: GoogleFonts
                                                                    .lato(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Container(
                                                                height: 10,
                                                                width: 10,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color:
                                                                      Colors.grey,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  d[index]['question'],
                                                  style: GoogleFonts.lato(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: dataLength,
                                ),
                              );
                            }
                          },
                        ),
                      )
                  ],
                ),
          floatingActionButton:
               cubit.isVisible == false
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: FloatingActionButton(
                        onPressed: () {
                          cubit.ChangeIsVisiableToTrue();
                        },
                        backgroundColor: mainColor,
                        child: Center(
                          child: Icon(
                            Icons.add_comment_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
        );
      },
    );
  }
}
