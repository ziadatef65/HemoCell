import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemo_cell/modules/needBlood/specificPlace/specific_place_screen.dart';

import '../../shared/components/components.dart';

class NeedBloodScreen extends StatelessWidget {
  const NeedBloodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Need Blood Bag',
              style: GoogleFonts.bangers(
                fontSize: 32,
                color: Color.fromRGBO(250, 128, 114, 1),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(250, 128, 114, 1),
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned(
                      right: 20,
                      bottom: -2,
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/image4.png'))),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 20,
                      right: 50,
                      bottom: 40,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dear patient',
                              style: GoogleFonts.bangers(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'The places in front of you are the places that we have contracted with, and soon we will expand and show you every place and the available blood bags it contains.',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight:FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 10,
                      child: Text(
                        'Life Saver',
                        style: GoogleFonts.bangers(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(250, 128, 114, 1),

                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned(
                      left: 20,
                      top: 10,
                      right: 20,
                      bottom: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'We have so far reached the number of hospitals and centers',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'But it is not the end, we will expand more than that',
                            style: GoogleFonts.lato(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 5,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('ourPlaces')
                              .snapshots(),
                          builder: (context, snapshot) {
                            var dataLength = snapshot.data?.docs.length;
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
                              return Text(
                                dataLength.toString(),
                                style: GoogleFonts.bangers(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('ourPlaces')
                          .snapshots(),
                      builder: (context, snapshot) {
                        var dataLength = snapshot.data?.docs.length;
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
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = snapshot.data?.docs[index].data();

                              return Container(
                                clipBehavior: Clip.hardEdge,
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: 5,
                                      top: 20,
                                      bottom: 0,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                    image: AssetImage('assets/images/image4.png'),
                                                opacity: 0.3)),
                                      ),
                                    ),
                                    Positioned(
                                      left: 15,
                                      top: 10,
                                      child: Text(
                                        '${data?['nameOfPlace']}',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SpecificPlaceBloodScreen(
                                                            data)));
                                          },
                                          icon: const Icon(
                                            Icons.chevron_right,
                                            size: 32,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, inedx) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: dataLength!,
                          );
                        }
                      }))),
        ],
      ),
    );
  }
}
