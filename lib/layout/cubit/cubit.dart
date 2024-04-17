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
    ProfileScreen(),
  ];
  List<Widget> screens2 = [
    HomeScreen(),
    DonateScreen(),
    NeedBloodScreen(),
    DashboardScreen(),
    ProfileScreen(),

  ];

  void changeBottomNavBar(dynamic index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  //........................this functions for user..................//

  // this function used to get the user data and display it in application
  UserModel? userModel;

  // void getUserData() {
  //   emit(GetUserLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .get()
  //       .then((dynamic value) {
  //     userModel = UserModel.fromJson(value.data());
  //     emit(GetUserSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetUserErrorState(error.toString()));
  //   });
  // }

  // void getOrdersData() {
  //   emit(GetUserLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('orders')
  //       .doc(userId)
  //       .get()
  //       .then((dynamic value) {
  //     orderModel = OrderModel.fromJson(value.data());
  //     emit(GetUserSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetUserErrorState(error.toString()));
  //   });
  // }
//


//
//   void updateUser({
//     required String name,
//     required String phone,
//     required String address,
//     String? image,
//   }) {
//     emit(UserUpdateLoading());
//
//     UserModel model = UserModel(
//       name: name,
//       phone: phone,
//       address: address,
//       image: image ?? userModel!.image,
//       email: userModel!.email,
//       userId: userModel!.userId,
//       isDelivery: userModel!.isDelivery!,
//       nationalId: userModel?.nationalId,
//       orderId: userModel?.orderId,
//       orderNow: userModel?.orderNow,
//       numberOfDonationMoney: userModel?.numberOfDonationMoney,
//       numberOfDonationFood: userModel?.numberOfDonationFood,
//       superAdmin: userModel?.superAdmin,
//     );
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userModel!.userId)
//         .update(model.toMap())
//         .then((value) {
//       getUserData();
//     }).catchError((error) {
//       emit(UserUpdateError());
//     });
//   }

//



  // delete order when it finished
  Stream<UserModel> get userModelStream => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .snapshots()
      .map((event) => UserModel.fromJson(event.data()!));







  ////

  //////////////////
}


//......................................................................//

