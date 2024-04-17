import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemo_cell/modules/register/cubit/states.dart';

import '../../../models/userModel.dart';
import '../../../shared/components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

// this method used to make user register and store the user information to database
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        userId: value.user!.uid,

      );
      userId = value.user!.uid;
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  // this method used to create regular user
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String userId,
  }) {
    UserModel model = UserModel(
        name: name,
        phone: phone,
        userId: userId,
        email: email,
        isAdmin: false,
        numberOfBloodDonations: 0,
        numberOfBloodRecipient: 0,
        listOfDonations: [],
        listOfBloodBags: [],
      listOfBloodByEvent: [],
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(userId));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }



}