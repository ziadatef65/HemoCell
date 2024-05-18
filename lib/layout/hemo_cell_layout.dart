import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemo_cell/shared/components/components.dart';
import 'package:hemo_cell/shared/components/constants.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HemoCellLayout extends StatelessWidget {

  HemoCellLayout({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainCubit, DonationStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = MainCubit.get(context);

          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users')
                .doc(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // Handle the case where data is not available yet.
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
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
                return Scaffold(
                  backgroundColor: Colors.white,
                  body:

                  snapshot.data?.data()?['isAdmin'] == true ? cubit.screens2[cubit.currentIndex] : cubit
                      .screens[cubit.currentIndex],
                  bottomNavigationBar:
                  snapshot.data?.data()?['isAdmin'] == true
                      ?
                  BottomNavigationBar(
                    onTap: (index) {
                      cubit.changeBottomNavBar(index);
                    },
                    currentIndex: cubit.currentIndex,
                    backgroundColor: CupertinoColors.white,
                    selectedItemColor: mainColor,
                    unselectedItemColor: Colors.black,
                    selectedLabelStyle:
                    const TextStyle(color: Color.fromRGBO(29, 38, 125, 10),),
                    elevation: 0,
                    items: const [

                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.house_rounded,
                          ),
                          label: 'Home',
                          backgroundColor: Colors.white
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                              Icons.bloodtype_outlined
                          ),
                          backgroundColor: Colors.white,

                          label: 'Donate'),
                      BottomNavigationBarItem(
                          icon: Icon(
                              CupertinoIcons.hand_raised_fill
                          ),
                          label: 'Need blood bag'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.dashboard),
                          backgroundColor: Colors.white,

                          label: 'Dashboard'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.question_answer),
                          backgroundColor: Colors.white,

                          label: 'Questions'),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.profile_circled),
                          backgroundColor: Colors.white,

                          label: 'Profile'),

                    ],
                  )
                      :
                  BottomNavigationBar(
                    onTap: (index) {
                      cubit.changeBottomNavBar(index);
                    },
                    currentIndex: cubit.currentIndex,
                    backgroundColor: Colors.white,
                    selectedItemColor: mainColor,
                    unselectedItemColor: Colors.black,
                    selectedLabelStyle:
                    const TextStyle(color: Color.fromRGBO(29, 38, 125, 10),),
                    elevation: 0,
                    items: const [

                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.house_rounded,
                          ),
                          label: 'Home',
                          backgroundColor: Colors.white
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                              Icons.bloodtype_outlined
                          ),
                          label: 'Donate',
                          backgroundColor: Colors.white
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                              CupertinoIcons.hand_raised_fill
                          ),
                          label: 'Need blood bag',
                          backgroundColor: Colors.white

                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                              Icons.question_answer
                          ),
                          label: 'Questions',
                          backgroundColor: Colors.white

                      ),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.profile_circled),
                          label: 'Profile',
                          backgroundColor: Colors.white

                      ),


                    ]
                    ,
                  )
                  ,
                );
              }
            }
          );
        }
    );
  }
}
