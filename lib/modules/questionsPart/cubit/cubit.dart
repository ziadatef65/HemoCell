import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemo_cell/modules/questionsPart/cubit/states.dart';

class AddQuestionCubit extends Cubit<AddQuestionsStates> {
  AddQuestionCubit() : super(AddQuestionsInitialState());

  static AddQuestionCubit get(context) => BlocProvider.of(context);

  Future<void> addQuestions(
    name,
    question,
    userId,
  ) async {
    final firestore = FirebaseFirestore.instance;
    final today = DateTime.now();
    final formattedDate = '${today.day}-${today.month}-${today.year}';
    final donationRef = firestore.collection('questions').doc(formattedDate);

    try {
      final docSnapshot = await donationRef.get();
      if (docSnapshot.exists) {
        // If document already exists for today's date, update it
        await donationRef.update({
          'questions': FieldValue.arrayUnion([
            {
              'name': name,
              'question': question,
              'answer': null,
              'category': null,
              'userId': userId,
              'refuseMessages': null,
              'timestampOfBegin': Timestamp.now(),
              'isAccepted': null,
            }
          ])
        });
      } else {
        // If document doesn't exist for today's date, create a new one
        await donationRef.set({
          'questions': [
            {
              'name': name,
              'question': question,
              'answer': null,
              'category': null,
              'userId': userId,
              'refuseMessages': null,
              'timestampOfBegin': Timestamp.now(),
              'isAccepted': null,
            }
          ]
        });
      }

      // Update user data
      final userRef = firestore.collection('users').doc(userId);
      final userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        await userRef.update({
          'listOfQuestions': FieldValue.arrayUnion([
            {
              'name': name,
              'question': question,
              'answer': null,
              'category': null,
              'userId': userId,
              'refuseMessages': null,
              'timestampOfBegin': Timestamp.now(),
              'isAccepted': null,
            }
          ]),
        });
      }
      emit(AddQuestionsSuccessfullyState());
    } catch (error) {
      emit(AddQuestionsErrorState(error.toString()));
    }
  }
  bool  isVisible  = false;
  void ChangeIsVisiableToFalse(){
    isVisible = false;
    emit(ChangeIndexSuccessfullyState());
  }
  void ChangeIsVisiableToTrue(){
    isVisible = true;
    emit(ChangeIndexSuccessfullyState());
  }
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
  ////////////////////////
  int indexOfTypesDiseases =1;
  void ChangeIndexOfTypesDiseasesTo1(){
    indexOfTypesDiseases = 1;
    emit(ChangeIndexSuccessfullyState());
  }
    void ChangeIndexOfTypesDiseasesTo2(){
    indexOfTypesDiseases = 2;
    emit(ChangeIndexSuccessfullyState());
  }

    void ChangeIndexOfTypesDiseasesTo3(){
    indexOfTypesDiseases = 3;
    emit(ChangeIndexSuccessfullyState());
  }
  void ChangeIndexOfTypesDiseasesTo4(){
    indexOfTypesDiseases = 4;
    emit(ChangeIndexSuccessfullyState());
  }




}
