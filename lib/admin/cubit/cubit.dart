import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemo_cell/admin/cubit/states.dart';
import 'package:hemo_cell/models/placeModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';

import '../../models/eventsModel.dart';
import '../../shared/components/constants.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());
  static AdminCubit get(context) => BlocProvider.of(context);
  EventModel? eventModel;
  PlaceModel? placeModel;
  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(EventImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(EventImagePickedErrorState());
    }
  }

  deleteEventImage() {
    profileImage = null;
    emit(DeleteEventImageSuccessState());
  }

  //////////////////////////////////////////////////////////////////
  void uploadProfileImage(
    String? nameOfEvent,
  ) {
    emit(UploadImageOfEventLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('events/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((dynamic value) {
        emit(UploadImageOfEventLoadingState());
        updateEventImage(
          nameOfEvent: nameOfEvent,
          imageOfEvent: value,
        );
      }).then((value) {
        emit(UploadProfileImageSuccessState());
      });
    }).catchError((error) {
      emit(UploadProfileImageSuccessState());
    });
  }

  void uploadPlaceImage(
    String? nameOfPlace,
  ) {
    emit(UploadImageOfEventLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('ourPlaces/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((dynamic value) {
        emit(UploadImageOfEventLoadingState());
        updatePlaceImage(
          nameOfplace: nameOfPlace,
          imageOfPlace: value,
        );
      }).then((value) {
        emit(UploadProfileImageSuccessState());
      });
    }).catchError((error) {
      emit(UploadProfileImageSuccessState());
    });
  }

  //////////////////////////////////////
  void eventCreate({
    required String nameOfEvent,
    String? image,
  }) {
    EventModel model = EventModel(
      nameOfEvent: nameOfEvent,
      imageOfEvent:
          'https://img.freepik.com/free-vector/error-404-concept-landing-page_52683-21190.jpg',
    );
    emit(CreateEventLoadingState(nameOfEvent));
    FirebaseFirestore.instance
        .collection('events')
        .doc(nameOfEvent)
        .set(model.toMap())
        .then((value) {
      emit(CreateEventSuccessState(nameOfEvent));
    }).catchError((error) {
      emit(CreateEventErrorState(error));
    });
  }

  void addPlace({
    required String nameOfPlace,
    String? image,
  }) {
    PlaceModel model = PlaceModel(
      nameOfPlace: nameOfPlace,
      imageOfPlace:
          'https://img.freepik.com/free-vector/error-404-concept-landing-page_52683-21190.jpg',
    );
    emit(CreateEventLoadingState(nameOfPlace));
    FirebaseFirestore.instance
        .collection('ourPlaces')
        .doc(nameOfPlace)
        .set(model.toMap())
        .then((value) {
      emit(CreateEventSuccessState(nameOfPlace));
    }).catchError((error) {
      emit(CreateEventErrorState(error));
    });
  }

  ////////////
  /////////////////////////
  void updateEventImage({
    String? nameOfEvent,
    String? imageOfEvent,
  }) {
    emit(UploadImageOfEventLoadingState());
    EventModel model = EventModel(
      nameOfEvent: nameOfEvent,
      imageOfEvent: imageOfEvent ?? eventModel!.imageOfEvent,
      target: 0,
      listOfDonations: [],
      usersId: [],
    );

    FirebaseFirestore.instance
        .collection('events')
        .doc(nameOfEvent)
        .update(model.toMap())
        .then((dynamic value) {
      eventModel!.imageOfEvent = value;
      emit(UploadImageOfEventSuccessState());
    }).catchError((error) {
      emit(UploadImageOfEventSuccessState());
    });
  }

  void updatePlaceImage({
    String? nameOfplace,
    String? imageOfPlace,
  }) {
    emit(UploadImageOfEventLoadingState());
    PlaceModel model = PlaceModel(
      nameOfPlace: nameOfplace,
      imageOfPlace: imageOfPlace ?? '',
      a1: 0,
      a2: 0,
      ab1: 0,
      ab2: 0,
      b1: 0,
      b2: 0,
      o1: 0,
      o2: 0,
      listOfNeedBlood: [],
    );

    FirebaseFirestore.instance
        .collection('ourPlaces')
        .doc(nameOfplace)
        .update(model.toMap())
        .then((dynamic value) {
      placeModel!.imageOfPlace = value;
      emit(UploadImageOfEventSuccessState());
    }).catchError((error) {
      emit(UploadImageOfEventSuccessState());
    });
  }

///////////////////////////
  void deleteEventFromFireBase(nameOfEvent) {
    FirebaseFirestore.instance
        .collection('events')
        .doc(nameOfEvent)
        .delete()
        .then((value) {
      emit(DeleteEventSuccessState());
    }).catchError((error) {
      emit(DeleteEventErrorState());
    });
  }

////////////////////////////////////
  final CollectionReference detailRef =
      FirebaseFirestore.instance.collection('events');
  void addDetailsOfEvent(
    String nameOfEvent,
    String detail,
  ) async {
    emit(AddDetailsOfEventLoadingState());
    await detailRef.doc(nameOfEvent).update({'details': detail}).then((value) {
      emit(AddDetailsOfEventSuccessState());
    }).catchError((error) {
      emit(AddDetailsOfEventErrorState());
    });
  }

  final CollectionReference detailPlaceRef =
      FirebaseFirestore.instance.collection('ourPlaces');
  void addDetailsOfPlace(
    String nameOfEvent,
    String detail,
  ) async {
    emit(AddDetailsOfEventLoadingState());
    await detailPlaceRef
        .doc(nameOfEvent)
        .update({'details': detail}).then((value) {
      emit(AddDetailsOfEventSuccessState());
    }).catchError((error) {
      emit(AddDetailsOfEventErrorState());
    });
  }

  ///////////////////////////////////////
  final CollectionReference targetRef =
      FirebaseFirestore.instance.collection('events');
  void addTargetOfEvent(
    String nameOfEvent,
    dynamic target,
  ) async {
    emit(AddTargetOfEventLoadingState());
    await targetRef
        .doc(nameOfEvent)
        .update({'fixedTarget': target}).then((value) {
      emit(AddTargetOfEventSuccessState());
    }).catchError((error) {
      emit(AddTargetOfEventErrorState());
    });
  }

  final CollectionReference hoursOfWorkRef =
      FirebaseFirestore.instance.collection('ourPlaces');
  void addHoursOfWork(
    String nameOfPlace,
    dynamic hoursOfWork,
  ) async {
    emit(AddTargetOfEventLoadingState());
    await hoursOfWorkRef
        .doc(nameOfPlace)
        .update({'hoursOfWork': hoursOfWork}).then((value) {
      emit(AddTargetOfEventSuccessState());
    }).catchError((error) {
      emit(AddTargetOfEventErrorState());
    });
  }

//////////////////////////////////////////
  addInformation(nameOfEvent, detail, fixedTarget) {
    addTargetOfEvent(nameOfEvent, fixedTarget);
    addDetailsOfEvent(nameOfEvent, detail);
    emit(DoneAddInfoSuccessState());
  }

  addInformationForPlace(nameOfPlace, detail, hoursOfWork) {
    addHoursOfWork(nameOfPlace, hoursOfWork);
    addDetailsOfPlace(nameOfPlace, detail);
    emit(DoneAddInfoSuccessState());
  }
///////////////////

  updateBloodBags(nameOfPlace, a1, a2, b1, b2, ab1, ab2, o1, o2) async {
    await hoursOfWorkRef.doc(nameOfPlace).update({
      'A+': a1,
      'A-': a2,
      'B+': b1,
      'B-': b2,
      'AB+': ab1,
      'AB-': ab2,
      'O+': o1,
      'O-': o2
    });
    emit(DoneAddInfoSuccessState());
  }
  ///////////////////////////////
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
  ////////////////////
  bool? addAnswer = null;
  changeAddAnswerToTrue (){
    addAnswer = true;
    emit(ChangeTrueToFalseOrFalseToTrueSuccessfullyState());

  }
  changeAddAnswerToFalse (){
    addAnswer = null;
    emit(ChangeTrueToFalseOrFalseToTrueSuccessfullyState());

  }
  bool? rejecteQuestion = null;
  changeRejectedQuestionToTrue (){
    rejecteQuestion = true;
    emit(ChangeTrueToFalseOrFalseToTrueSuccessfullyState());

  }
  changeRejectedQuestionToFalse (){
    rejecteQuestion = null;
    emit(ChangeTrueToFalseOrFalseToTrueSuccessfullyState());

  }
  String selectedDisease = '';
  assignDisease (value){
    selectedDisease = value;
    emit(ChangeTrueToFalseOrFalseToTrueSuccessfullyState());

  }
  //////////////////////
  String formatTimestamp(Timestamp timestamp) {
    // Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime
    String formattedDate = DateFormat.yMMMMd().add_jm().add_j().format(dateTime);

    // Add timezone information
    formattedDate += " UTC+3";

    return formattedDate;
  }




  // void updateIsDoneToFalseForRegularDonation( eventId,  useId,  time) {
  //   CollectionReference events = FirebaseFirestore.instance.collection('regularDonations');
  //
  //   // Get the document reference for the event
  //   DocumentReference eventRef = events.doc(eventId);
  //
  //   // Update the isDone field to true for the donation at the specified index
  //   eventRef.get().then((eventDoc) {
  //     // Check if the document exists
  //     if (eventDoc.exists) {
  //       // Cast the data to a Map<String, dynamic>
  //       Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;
  //
  //       // Retrieve listOfDonations from the eventData
  //       List<dynamic> listOfDonations = eventData['donations'];
  //
  //       // Update the isDone field of the donation at the specified index
  //       for (int i = 0; i < listOfDonations.length; i++) {
  //         // Get the current donation map
  //         Map<String, dynamic> donation = listOfDonations[i];
  //
  //         // Check if the userId and timestamp match
  //         if (donation['userId'] == useId && donation['timestampOfBegin'] == time) {
  //           // Update the isDone field to true
  //           listOfDonations[i]['isDone'] = false;
  //           break; // Exit loop since we found the matching donation
  //         }
  //       }
  //
  //       // Update the event document with the modified listOfDonations
  //       eventRef.update({'donations': listOfDonations}).then((_) {
  //         print("Document updated successfully");
  //         updateIsDoneToFalseForUserForRegularDonations(useId, time);
  //       }).catchError((error) => print("Failed to update document: $error"));
  //     } else {
  //       print("Event document not found.");
  //     }
  //   }).catchError((error) => print("Error getting event document: $error"));
  // }
  // void updateIsDoneToFalseForUserForRegularDonations(useId, time) {
  //   CollectionReference usersCollection =
  //   FirebaseFirestore.instance.collection('users');
  //
  //   // Get the document reference for the user
  //   DocumentReference userRef = usersCollection.doc(useId);
  //
  //   // Get the user document and update isDone field for matching donation
  //   userRef.get().then((userDoc) {
  //     // Check if the user document exists and contains the expected data
  //     if (userDoc.exists) {
  //       // Cast the data to Map<String, dynamic>
  //       Map<String, dynamic>? userData =
  //       userDoc.data() as Map<String, dynamic>?;
  //
  //       // Check if userData is not null and contains the expected field
  //       if (userData != null && userData.containsKey('listOfDonations')) {
  //         // Get the list of donations from the userData
  //         List<dynamic> listOfDonations = userData['listOfDonations'];
  //
  //         // Iterate through the list of donations
  //         for (int i = 0; i < listOfDonations.length; i++) {
  //           // Get the current donation map
  //           Map<String, dynamic> donation = listOfDonations[i];
  //
  //           // Check if the name and time match
  //           if (
  //           donation['userId'] == useId
  //               &&
  //               formatTimestamp( donation['timestampOfBegin']) == formatTimestamp(time)
  //
  //           ) {
  //             // Update the isDone field to false
  //
  //             listOfDonations[i]['isDone'] = false;
  //             break; // Exit loop since we found the matching donation
  //           }
  //         }
  //
  //         // Update the user document with the modified listOfDonations
  //         userRef
  //             .update({'listOfDonations': listOfDonations})
  //             .then((_) => print("Document updated successfully"))
  //             .catchError(
  //                 (error) => print("Failed to update document: $error"));
  //       } else {
  //         print("User data is missing the expected field.");
  //       }
  //     } else {
  //       print("User document not found.");
  //     }
  //   }).catchError((error) => print("Error getting user document: $error"));
  // }
  ///////////////////
  void addAnswerForQuestion( eventId,  useId,  time,Question,answer,category) {
    emit(AddAnswerLoadingState());
    CollectionReference events = FirebaseFirestore.instance.collection('questions');

    // Get the document reference for the event
    DocumentReference eventRef = events.doc(eventId);

    // Update the isDone field to true for the donation at the specified index
    eventRef.get().then((eventDoc) {
      // Check if the document exists
      if (eventDoc.exists) {
        // Cast the data to a Map<String, dynamic>
        Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;

        // Retrieve listOfDonations from the eventData
        List<dynamic> listOfDonations = eventData['questions'];

        // Update the isDone field of the donation at the specified index
        for (int i = 0; i < listOfDonations.length; i++) {
          // Get the current donation map
          Map<String, dynamic> donation = listOfDonations[i];

          // Check if the userId and timestamp match
          if (donation['userId'] == useId && donation['timestampOfBegin'] == time) {
            // Update the isDone field to true
            listOfDonations[i]['isAccepted'] = true;
            listOfDonations[i]['answer'] = answer;
            listOfDonations[i]['category'] = category;
            break; // Exit loop since we found the matching donation
          }
        }

        // Update the event document with the modified listOfDonations
        eventRef.update({'questions': listOfDonations}).then((_) {
          answerQuestionsForUser(useId, time,Question,answer,category);
          emit(AddAnswerSuccefullyState());

        }).catchError((error) => print("Failed to update document: $error"));
      } else {
        print("Event document not found.");
      }
    }).catchError((error) {    emit(AddAnswerErrorState());});
  }
  void answerQuestionsForUser(useId, time,Question,answer,category) {
    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    // Get the document reference for the user
    DocumentReference userRef = usersCollection.doc(useId);

    // Get the user document and update isDone field for matching donation
    userRef.get().then((userDoc) {
      // Check if the user document exists and contains the expected data
      if (userDoc.exists) {
        // Cast the data to Map<String, dynamic>
        Map<String, dynamic>? userData =
        userDoc.data() as Map<String, dynamic>?;

        // Check if userData is not null and contains the expected field
        if (userData != null && userData.containsKey('listOfQuestions')) {
          // Get the list of donations from the userData
          List<dynamic> listOfQuestions = userData['listOfQuestions'];

          // Iterate through the list of donations
          for (int i = 0; i < listOfQuestions.length; i++) {
            // Get the current donation map
            Map<String, dynamic> question = listOfQuestions[i];

            // Check if the name and time match
            if (
            question['userId'] == useId
                &&
                formatTimestamp( question['timestampOfBegin']) == formatTimestamp(time)
                && question['question'] == Question
            ) {
              // Update the isDone field to false

              listOfQuestions[i]['isAccepted'] = true;
              listOfQuestions[i]['answer'] = answer;
              listOfQuestions[i]['category'] = category;
              break; // Exit loop since we found the matching donation
            }
          }

          // Update the user document with the modified listOfDonations
          userRef
              .update({'listOfQuestions': listOfQuestions})
              .then((_) => print("Document updated successfully"))
              .catchError(
                  (error) => print("Failed to update document: $error"));
        } else {
          print("User data is missing the expected field.");
        }
      } else {
        print("User document not found.");
      }
    }).catchError((error) => print("Error getting user document: $error"));
  }
  ///////////////////////
  void refuseQuestion( eventId,  useId,  time,Question,refuseMessages) {
    emit(RefuseAnswerLoadingState());
    CollectionReference events = FirebaseFirestore.instance.collection('questions');

    // Get the document reference for the event
    DocumentReference eventRef = events.doc(eventId);

    // Update the isDone field to true for the donation at the specified index
    eventRef.get().then((eventDoc) {
      // Check if the document exists
      if (eventDoc.exists) {
        // Cast the data to a Map<String, dynamic>
        Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;

        // Retrieve listOfDonations from the eventData
        List<dynamic> listOfDonations = eventData['questions'];

        // Update the isDone field of the donation at the specified index
        for (int i = 0; i < listOfDonations.length; i++) {
          // Get the current donation map
          Map<String, dynamic> donation = listOfDonations[i];

          // Check if the userId and timestamp match
          if (donation['userId'] == useId && donation['timestampOfBegin'] == time) {
            // Update the isDone field to true
            listOfDonations[i]['isAccepted'] = false;
            listOfDonations[i]['refuseMessages'] = refuseMessages;
            break; // Exit loop since we found the matching donation
          }
        }

        // Update the event document with the modified listOfDonations
        eventRef.update({'questions': listOfDonations}).then((_) {
          refuseQuestionsForUser(useId, time,Question,refuseMessages);
          emit(RefuseSuccefullyState());

        }).catchError((error) => print("Failed to update document: $error"));
      } else {
        print("Event document not found.");
      }
    }).catchError((error) {    emit(RefuseAnswerErrorState());});
  }
  void refuseQuestionsForUser(useId, time,Question,refuseMessages) {
    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    // Get the document reference for the user
    DocumentReference userRef = usersCollection.doc(useId);

    // Get the user document and update isDone field for matching donation
    userRef.get().then((userDoc) {
      // Check if the user document exists and contains the expected data
      if (userDoc.exists) {
        // Cast the data to Map<String, dynamic>
        Map<String, dynamic>? userData =
        userDoc.data() as Map<String, dynamic>?;

        // Check if userData is not null and contains the expected field
        if (userData != null && userData.containsKey('listOfQuestions')) {
          // Get the list of donations from the userData
          List<dynamic> listOfQuestions = userData['listOfQuestions'];

          // Iterate through the list of donations
          for (int i = 0; i < listOfQuestions.length; i++) {
            // Get the current donation map
            Map<String, dynamic> question = listOfQuestions[i];

            // Check if the name and time match
            if (
            question['userId'] == useId
                &&
                formatTimestamp( question['timestampOfBegin']) == formatTimestamp(time)
                && question['question'] == Question
            ) {
              // Update the isDone field to false

              listOfQuestions[i]['isAccepted'] = false;
              listOfQuestions[i]['refuseMessages'] = refuseMessages;
              break; // Exit loop since we found the matching donation
            }
          }

          // Update the user document with the modified listOfDonations
          userRef
              .update({'listOfQuestions': listOfQuestions})
              .then((_) => print("Document updated successfully"))
              .catchError(
                  (error) => print("Failed to update document: $error"));
        } else {
          print("User data is missing the expected field.");
        }
      } else {
        print("User document not found.");
      }
    }).catchError((error) => print("Error getting user document: $error"));
  }
}
