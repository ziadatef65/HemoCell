import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemo_cell/admin/dashboard/dashboard_screen.dart';
import 'package:hemo_cell/layout/cubit/states.dart';
import 'package:hemo_cell/modules/donate/donate_screen.dart';
import 'package:hemo_cell/modules/home/home_screen.dart';
import 'package:hemo_cell/modules/needBlood/need_blood_screen.dart';
import 'package:hemo_cell/modules/profile/profile_screen.dart';

import '../../models/userModel.dart';
import '../../modules/questionsPart/questions_screen.dart';
import '../../shared/components/constants.dart';

class MainCubit extends Cubit<DonationStates> {
  MainCubit() : super(DonationInitialState());

  static MainCubit get(context) => BlocProvider.of(context);


// here the function that make the icon of bottomNavigationBar change
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    DonateScreen(),
    NeedBloodScreen(),
    QuestionsPage(),
    ProfileScreen(),
  ];
  List<Widget> screens2 = [
    HomeScreen(),
    DonateScreen(),
    NeedBloodScreen(),
    DashboardScreen(),
    QuestionsPage(),
    ProfileScreen(),

  ];

  void changeBottomNavBar(dynamic index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }


  ///////////////////////////////////
  int indexOfChangePages =1;
  void ChangeOfIndexOfPages1(){
    indexOfChangePages = 1;
    emit(ChangeIndexSuccessfullyState());
  }
  void ChangeOfIndexOfPages2(){
    indexOfChangePages = 2;
    emit(ChangeIndexSuccessfullyState());

  }
  void ChangeOfIndexOfPages3(){
    indexOfChangePages = 3;
    emit(ChangeIndexSuccessfullyState());

  }




  //////////////////////////////////
  //........................this functions for user..................//

  // this function used to get the user data and display it in application
  UserModel? userModel;

  Stream<UserModel> get userModelStream => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .snapshots()
      .map((event) => UserModel.fromJson(event.data()!));




}



