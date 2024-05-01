import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemo_cell/models/donateModel2.dart';
import 'package:hemo_cell/modules/donate/cubit/states.dart';
import 'package:hemo_cell/shared/components/constants.dart';

import '../../../models/donateByEventModel.dart';

class DonateCubit extends Cubit<DonateBloodStates>{

  DonateCubit():super(DonateBloodInitialState());
  static DonateCubit get(context) => BlocProvider.of(context);




  donateByEvent(nameOfEvent,name,age,gender,donateBloodBefore,chronicDiseases,periodOfDonatedBefore) async {



    // emit(CreateVoteLoadingState());
    var model = DonateByEventModel(
        donates: [
          {
            'name': name,
            'age': age,
            'gender': gender,
            'Donate blood before': donateBloodBefore,
            'Chronic diseases': chronicDiseases,
            'Period of donated before': periodOfDonatedBefore,
            'Time of donate': Timestamp.now(),
            'userId':userId,
            'isDone':null,
          }]);
    var model2 = DonateModel2(
      name: name,
      age: age,
      gender: gender,
      donateBloodBefore: donateBloodBefore,
      chronicDiseases: chronicDiseases,
      periodOfDonatedBefore: periodOfDonatedBefore,
      timestampOfBegin: Timestamp.now(),
      userId: userId,
      nameOfEvent: nameOfEvent,
      isDone: null,
    );

    final docSnapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc(nameOfEvent)
        .get();
    if (docSnapshot.exists) {
      final doc = FirebaseFirestore.instance.collection('events').doc(nameOfEvent);
      final docSnapshot = await doc.get();
      var data = docSnapshot.data();

      await FirebaseFirestore.instance
          .collection('events')
          .doc(nameOfEvent)
          .update({
        'usersId': FieldValue.arrayUnion([userId]),


      });
      await FirebaseFirestore.instance
          .collection('events')
          .doc(nameOfEvent)
          .update({
        'lisOfDonations': FieldValue.arrayUnion([model2.toMap()]),


      }).then((value) async {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        if (docSnapshot.exists) {

          // Document exists, update it
           FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'listOfBloodByEvent': FieldValue.arrayUnion([model2.toMap()]),
          }).then((value)  {

            emit(DonateByEventSuccessfullyState());
            int currentRateOneStar = data?['target'] ?? 0;
            int newRateOneStar = currentRateOneStar + 1;
            FirebaseFirestore.instance.collection('events').doc(nameOfEvent).update({'target':newRateOneStar});
          }).catchError((error) {
            emit(DonateByEventErrorState(error.toString()));
            print(error);
          });
        }
        emit(DonateByEventSuccessfullyState());
      }).catchError((error) {
        emit(DonateByEventErrorState(error.toString()));
      });
    }
    else {
      // Document does not exist, create it
      await FirebaseFirestore.instance
          .collection('events')
          .doc(nameOfEvent)
          .update({'lisOfDonations':model.toMap()})
          .then((value) async {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (docSnapshot.exists) {
          // Document exists, update it
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'listOfBloodByEvent': FieldValue.arrayUnion([model2.toMap()]),
          }).then((value) {
            emit(DonateByEventSuccessfullyState());
          }).catchError((error) {
            emit(DonateByEventErrorState(error.toString()));
            print(error);
          });
        }
        emit(DonateByEventSuccessfullyState());
      }).catchError((error) {
        emit(DonateByEventSuccessfullyState());
      });
    }

  }




}