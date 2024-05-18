import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemo_cell/admin/cubit/cubit.dart';
import 'package:hemo_cell/admin/cubit/states.dart';
import 'package:hemo_cell/shared/components/constants.dart';
import 'package:intl/intl.dart';

import '../../shared/components/components.dart';

class SpecificQuestionsPage extends StatelessWidget {
  var answerController = TextEditingController();
  var refuseMessageController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var userId;
  var time;
  var question;
  final nameOfDoc;

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate().toLocal();
    var formatter = DateFormat('MMMM dd, yyyy h:mm a');

    return formatter.format(dateTime);
  }

  SpecificQuestionsPage(this.nameOfDoc);

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);

    return BlocConsumer<AdminCubit, AdminStates>(listener: (context, state) {
      if (state is AddAnswerSuccefullyState) {
        showToast(text: 'Answer added successfully', state: ToastState.SUCCESS);

        cubit.changeAddAnswerToFalse();
        answerController.clear();
      }
      if (state is RefuseSuccefullyState) {
        showToast(text: 'Refused message added successfully', state: ToastState.SUCCESS);

        cubit.changeRejectedQuestionToFalse();
        refuseMessageController.clear();
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: cubit.addAnswer == true && cubit.rejecteQuestion == null
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
                              height: 520,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: mainColor, width: 3)),
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
                                          cubit.changeAddAnswerToFalse();
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20,
                                        left: 20,
                                        right: 20,
                                        top: 30),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Answer must not be empty";
                                        }
                                        return null;
                                      },
                                      controller: answerController,
                                      keyboardType: TextInputType.text,
                                      maxLines: 7,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: mainColor,
                                            width: 2,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                            color: mainColor,
                                            width: 2,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white.withOpacity(1),
                                        hintText: "Answer...",
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 5),
                                    child: DropdownButton<String>(
                                      iconEnabledColor: mainColor,
                                      iconDisabledColor: mainColor,
                                      borderRadius: BorderRadius.circular(15),
                                      isExpanded: true,
                                      value: cubit.selectedDisease.isNotEmpty
                                          ? cubit.selectedDisease
                                          : null,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18.0),
                                      onChanged: (newValue) {
                                        cubit.assignDisease(newValue);
                                      },
                                      items: <String>[
                                        'Anemia',
                                        'Infectious diseases',
                                        'Chronic diseases'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
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
                                      child: TextButton(
                                        child: Text(
                                          'Add answer',
                                          style: GoogleFonts.bangers(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.addAnswerForQuestion(
                                              nameOfDoc,
                                              userId,
                                              time,
                                              question,
                                              answerController.text,
                                              cubit.selectedDisease,
                                            );
                                          }
                                        },
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
                  ),
                )
              : cubit.addAnswer == null && cubit.rejecteQuestion == true
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
                        height: 450,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border:
                            Border.all(color: mainColor, width: 3)),
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
                                    cubit.changeRejectedQuestionToFalse();
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 20,
                                  right: 20,
                                  top: 30),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Refuse message must not be empty";
                                  }
                                  return null;
                                },
                                controller: refuseMessageController,
                                keyboardType: TextInputType.text,
                                maxLines: 7,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: mainColor,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: mainColor,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(1),
                                  hintText: "Refuse message...",
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
                                child: TextButton(
                                  child: Text(
                                    'Add refuse message',
                                    style: GoogleFonts.bangers(
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!
                                        .validate()) {
                                      cubit.refuseQuestion(
                                        nameOfDoc,
                                        userId,
                                        time,
                                        question,
                                        refuseMessageController.text,
                                      );
                                    }
                                  },
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
            ),
          )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.chevron_left,
                                    size: 32,
                                    color: mainColor,
                                  )),
                              Text(
                                nameOfDoc,
                                style: GoogleFonts.bangers(
                                    fontSize: 24, color: mainColor),
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
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cubit.ChangeOfIndexOfPages1();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: cubit.indexOfChangePages == 1
                                              ? mainColor
                                              : Colors.black,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(50),
                                              topLeft: Radius.circular(50))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'Waiting questions',
                                              style: GoogleFonts.lato(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cubit.ChangeOfIndexOfPages2();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cubit.indexOfChangePages == 2
                                            ? mainColor
                                            : Colors.black,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'Accepted questions',
                                              style: GoogleFonts.lato(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cubit.ChangeOfIndexOfPages3();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: cubit.indexOfChangePages == 3
                                              ? mainColor
                                              : Colors.black,
                                          borderRadius: const BorderRadius.only(
                                              bottomRight: Radius.circular(50),
                                              topRight: Radius.circular(50))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'Rejected questions',
                                              style: GoogleFonts.lato(
                                                  color: Colors.white),
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
                        ),
                        if (cubit.indexOfChangePages == 1)
                          Expanded(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('questions')
                                  .doc(nameOfDoc)
                                  .snapshots(),
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
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var d = snapshot.data
                                          ?.data()?['questions']
                                          .where((d) => d['isAccepted'] == null)
                                          .toList();
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 20, right: 20),
                                        child: Container(
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
                                                top: 10,
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
                                                    color: Colors.white,
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
                                                    const Icon(
                                                      CupertinoIcons.clock,
                                                      color: Colors.white,
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
                                                        color: Colors.white,
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
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color:
                                                                  Colors.black),
                                                          child: Center(
                                                            child: TextButton(
                                                              child: Text(
                                                                  'Reject',
                                                                  style: GoogleFonts
                                                                      .bangers(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  )),
                                                              onPressed: () {
                                                                cubit.changeRejectedQuestionToTrue();
                                                                userId = d[
                                                                index]
                                                                ['userId'];
                                                                time = d[index][
                                                                'timestampOfBegin'];
                                                                question = d[
                                                                index][
                                                                'question'];
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color:
                                                                  Colors.green),
                                                          child: Center(
                                                            child: TextButton(
                                                              child: Text(
                                                                  'Accept',
                                                                  style: GoogleFonts
                                                                      .bangers(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  )),
                                                              onPressed: () {
                                                                cubit
                                                                    .changeAddAnswerToTrue();
                                                                userId = d[
                                                                        index]
                                                                    ['userId'];
                                                                time = d[index][
                                                                    'timestampOfBegin'];
                                                                question = d[
                                                                        index][
                                                                    'question'];
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: snapshot.data
                                        ?.data()?['questions']
                                        .where((d) => d['isAccepted'] == null)
                                        .length,
                                  );
                                }
                              },
                            ),
                          ),
                        if (cubit.indexOfChangePages == 2)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: mainColor
                                ),
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('questions')
                                      .doc(nameOfDoc)
                                      .snapshots(),
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
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var d = snapshot.data
                                                ?.data()?['questions']
                                                .where((d) => d['isAccepted'] == true)
                                                .toList();
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20,bottom: 20),
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
                                                        'Answer: ${d[index]['answer']}',
                                                        style: GoogleFonts.lato(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                        ),


                                                      if (d[index]['category']=="Infectious diseases")
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                height: 20,
                                                                width: 220,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        15),
                                                                    color:
                                                                    mainColor),
                                                                child: Center(
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                            10,
                                                                            top:
                                                                            1,
                                                                            bottom:
                                                                            1),
                                                                        child:
                                                                        Text(
                                                                          'Accepted',
                                                                          style:
                                                                          GoogleFonts.lato(
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                            color:
                                                                            Colors.white,
                                                                            fontSize:
                                                                            12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                        5,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                        30,
                                                                        width:
                                                                        2,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                        10,
                                                                      ),
                                                                      Text(
                                                                        'Infectious diseases',
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          fontWeight:
                                                                          FontWeight.bold,
                                                                          color:
                                                                          Colors.white,
                                                                          fontSize:
                                                                          12,
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      Container(
                                                                        height:
                                                                        8,
                                                                        width:
                                                                        20,
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                            BoxShape.circle,
                                                                            color: Colors.amber),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                        5,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if(d[index]['category']=="Chronic diseases")
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                height: 20,
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    color: mainColor
                                                                ),
                                                                child: Center(
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 10,top: 1,bottom:1),
                                                                        child: Text('Accepted',
                                                                          style: GoogleFonts.lato(
                                                                            fontWeight:FontWeight.bold,
                                                                            color:Colors.white,
                                                                            fontSize:12,
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      SizedBox(width: 5,),
                                                                      Container(
                                                                        height: 30,
                                                                        width: 2,
                                                                        color: Colors.white,
                                                                      ),
                                                                      SizedBox(width: 10,),

                                                                      Text('Chronic diseases',
                                                                        style: GoogleFonts.lato(
                                                                          fontWeight:FontWeight.bold,
                                                                          color:Colors.white,
                                                                          fontSize:12,
                                                                        ),
                                                                      ),
                                                                      Spacer(),

                                                                      Container(
                                                                        height: 8,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.teal
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 5,),

                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if (d[index]['category'] == "Anemia")
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                height: 20,
                                                                width: 150,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        15),
                                                                    color:
                                                                    mainColor),
                                                                child: Center(
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                            10,
                                                                            top:
                                                                            1,
                                                                            bottom:
                                                                            1),
                                                                        child:
                                                                        Text(
                                                                          'Accepted',
                                                                          style:
                                                                          GoogleFonts.lato(
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                            color:
                                                                            Colors.white,
                                                                            fontSize:
                                                                            12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                        5,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                        30,
                                                                        width:
                                                                        2,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                        10,
                                                                      ),
                                                                      Text(
                                                                        'Anemia',
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          fontWeight:
                                                                          FontWeight.bold,
                                                                          color:
                                                                          Colors.white,
                                                                          fontSize:
                                                                          12,
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      Container(
                                                                        height:
                                                                        8,
                                                                        width:
                                                                        20,
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                            BoxShape.circle,
                                                                            color: Colors.blue),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                        5,
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
                                          itemCount: snapshot.data
                                              ?.data()?['questions']
                                              .where((d) => d['isAccepted'] == true)
                                              .length,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        if (cubit.indexOfChangePages == 3)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: mainColor
                                ),
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('questions')
                                      .doc(nameOfDoc)
                                      .snapshots(),
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
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var d = snapshot.data
                                                ?.data()?['questions']
                                                .where((d) => d['isAccepted'] == false)
                                                .toList();
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20,bottom: 20),
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
                                                                width: 200,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    color: mainColor
                                                                ),
                                                                child: Center(
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 10,top: 1,bottom:1),
                                                                        child: Text('Rejected',
                                                                          style: GoogleFonts.lato(
                                                                            fontWeight:FontWeight.bold,
                                                                            color:Colors.white,
                                                                            fontSize:12,
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      SizedBox(width: 5,),
                                                                      Container(
                                                                        height: 30,
                                                                        width: 2,
                                                                        color: Colors.white,
                                                                      ),
                                                                      SizedBox(width: 10,),

                                                                      Text('Chronic diseases',
                                                                        style: GoogleFonts.lato(
                                                                          fontWeight:FontWeight.bold,
                                                                          color:Colors.white,
                                                                          fontSize:12,
                                                                        ),
                                                                      ),
                                                                      Spacer(),

                                                                      Container(
                                                                        height: 8,
                                                                        width: 20,
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.teal
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 5,),

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
                                          itemCount: snapshot.data
                                              ?.data()?['questions']
                                              .where((d) => d['isAccepted'] == false)
                                              .length,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
        ),
      );
    });
  }
}
