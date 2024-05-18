import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemo_cell/admin/detailsOfDonations/cubit/states.dart';
import 'package:hemo_cell/shared/components/constants.dart';
import 'package:intl/intl.dart';


class DetailsCubit extends Cubit<DetailsDonationsStates> {
  DetailsCubit() : super(DetailsDonationsInitialState());
  static DetailsCubit get(context) => BlocProvider.of(context);
  /////////////////
  int indexOfChangePages = 0;
  void ChangeOfIndexOfPages1() {
    indexOfChangePages = 1;
    emit(ChangeIndexSuccessfullyState());
  }

  void ChangeOfIndexOfPages2() {
    indexOfChangePages = 2;
    emit(ChangeIndexSuccessfullyState());
  }

  void ChangeOfIndexOfPages3() {
    indexOfChangePages = 3;
    emit(ChangeIndexSuccessfullyState());
  }

  /////////////////
  void updateIsDoneToTrue(String eventId,  useId, name, time) {
    // Reference to the Firestore collection
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');

    // Get the document reference for the event
    DocumentReference eventRef = events.doc(eventId);

    // Update the isDone field to true for the donation at the specified index
    eventRef.get().then((eventDoc) {
      // Cast the data to a Map<String, dynamic>
      Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;

      // Retrieve listOfDonations from the eventData
      List<dynamic> listOfDonations = eventData['listOfDonations'];

      // Update the isDone field of the donation at the specified index

      // Update the event document with the modified listOfDonations
      for (int i = 0; i < listOfDonations.length; i++) {
        // Get the current donation map
        Map<String, dynamic> donation = listOfDonations[i];

        // Check if the name and time match
        if (donation['nameOfEvent'] == name &&
            donation['timestampOfBegin'] == time &&
            donation['userId'] == useId
        ) {
          // Update the isDone field to false

          listOfDonations[i]['isDone'] = true;
          break; // Exit loop since we found the matching donation
        }
      }

      // Update the user document with the modified listOfDonations
      eventRef
          .update({'listOfDonations': listOfDonations})
          .then((_) => print("Document updated successfully"))
          .catchError(
              (error) => print("Failed to update document: $error"));
    }).then((value) {
      updateIsDoneToTrueForUser(eventId, useId, name, time);
    });
  }

  void updateIsDoneToTrueForUser(String eventId, useId, name, time) {
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
        if (userData != null && userData.containsKey('listOfBloodByEvent')) {
          // Get the list of donations from the userData
          List<dynamic> listOfDonations = userData['listOfBloodByEvent'];

          // Iterate through the list of donations
          for (int i = 0; i < listOfDonations.length; i++) {
            // Get the current donation map
            Map<String, dynamic> donation = listOfDonations[i];

            // Check if the name and time match
            if (
            donation['nameOfEvent'] == name &&
                formatTimestamp( donation['timestampOfBegin']) == formatTimestamp(time) &&
                donation['userId'] == useId

            ) {
              // Update the isDone field to false

              listOfDonations[i]['isDone'] = true;
              break; // Exit loop since we found the matching donation
            }
          }

          // Update the user document with the modified listOfDonations
          userRef
              .update({'listOfBloodByEvent': listOfDonations})
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
  void updateIsDoneToFalse(String eventId, useId, name, time) {
    // Reference to the Firestore collection
    CollectionReference events =
    FirebaseFirestore.instance.collection('events');

    // Get the document reference for the event
    DocumentReference eventRef = events.doc(eventId);

    // Update the isDone field to true for the donation at the specified index
    eventRef.get().then((eventDoc) {
      // Cast the data to a Map<String, dynamic>
      Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;

      // Retrieve listOfDonations from the eventData
      List<dynamic> listOfDonations = eventData['listOfDonations'];

      // Update the isDone field of the donation at the specified index
      for (int i = 0; i < listOfDonations.length; i++) {
        // Get the current donation map
        Map<String, dynamic> donation = listOfDonations[i];

        // Check if the name and time match
        if (donation['nameOfEvent'] == name &&
            donation['timestampOfBegin'] == time
            &&
            donation['userId'] == useId
        ) {
          // Update the isDone field to false

          listOfDonations[i]['isDone'] = false;
          break; // Exit loop since we found the matching donation
        }
      }

      // Update the user document with the modified listOfDonations
      eventRef
          .update({'listOfDonations': listOfDonations})
          .then((_) => print("Document updated successfully"))
          .catchError(
              (error) => print("Failed to update document: $error"));
    }).then((value) {
      updateIsDoneToFalseForUser(useId, name, time);
      updateTarget(eventId);
    });
  }

  void updateIsDoneToFalseForUser(String useId, name, time) {
    // Reference to the Firestore collection
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
        if (userData != null && userData.containsKey('listOfBloodByEvent')) {
          // Get the list of donations from the userData
          List<dynamic> listOfDonations = userData['listOfBloodByEvent'];

          // Iterate through the list of donations
          for (int i = 0; i < listOfDonations.length; i++) {
            // Get the current donation map
            Map<String, dynamic> donation = listOfDonations[i];

            // Check if the name and time match
            if (donation['nameOfEvent'] == name &&
                formatTimestamp( donation['timestampOfBegin']) == formatTimestamp(time)
                &&
                donation['userId'] == useId
            ) {
              // Update the isDone field to false
              listOfDonations[i]['isDone'] = false;
              break; // Exit loop since we found the matching donation
            }
          }

          // Update the user document with the modified listOfDonations
          userRef
              .update({'listOfBloodByEvent': listOfDonations})
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

  void updateTarget(String eventId) async {
    final doc = FirebaseFirestore.instance.collection('events').doc(eventId);
    final docSnapshot = await doc.get();
    var data = docSnapshot.data();

    int currentRateOneStar = data?['target'] ?? 0;
    int newRateOneStar = currentRateOneStar - 1;
    FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .update({'target': newRateOneStar});
  }

////////////////////////////////////////////

  void updateIsDoneToTrueForNeedBloodBags(String nameOfDoc, useId, time, amountOfBags, typeOfBlood) {
    CollectionReference events = FirebaseFirestore.instance.collection('ourPlaces');

    // Get the document reference for the event
    DocumentReference eventRef = events.doc(nameOfDoc);

    // Update the isDone field to true for the donation at the specified index
    eventRef.get().then((eventDoc) {
      // Check if the document exists
      if (eventDoc.exists) {
        // Cast the data to a Map<String, dynamic>
        Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;

        // Retrieve listOfDonations from the eventData
        List<dynamic> listOfDonations = eventData['listOfNeedBlood'];

        // Update the isDone field of the donation at the specified index
        for (int i = 0; i < listOfDonations.length; i++) {
          // Get the current donation map
          Map<String, dynamic> donation = listOfDonations[i];

          // Check if the userId and timestamp match
          for (int i = 0; i < listOfDonations.length; i++) {
            // Get the current donation map
            Map<String, dynamic> donation = listOfDonations[i];

            // Check if the name and time match
            if (donation['userId'] == useId &&
                donation['timestampOfBegin'] == time &&
                donation['amountOfBags'] == amountOfBags &&
                donation['typeOfBlood'] == typeOfBlood) {
              // Update the isDone field to false

              listOfDonations[i]['isDone'] = true;
              break; // Exit loop since we found the matching donation
            }
          }

          // Update the event document with the modified listOfDonations
          eventRef.update({'listOfNeedBlood': listOfDonations}).then((_) {
            print("Document updated successfully");
            updateIsDoneToTrueForUserForNeedBloodBags(useId, time,amountOfBags, typeOfBlood);
          }).catchError((error) => print("Failed to update document: $error"));
        }
      } else {
        print("Event document not found.");
      }
    }).catchError((error) => print("Error getting event document: $error"));
  }
  void updateIsDoneToTrueForUserForNeedBloodBags(useId, time, amountOfBags, typeOfBlood) {
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
        if (userData != null && userData.containsKey('listOfBloodBags')) {
          // Get the list of donations from the userData
          List<dynamic> listOfDonations = userData['listOfBloodBags'];

          // Iterate through the list of donations
          for (int i = 0; i < listOfDonations.length; i++) {
            // Get the current donation map
            Map<String, dynamic> donation = listOfDonations[i];

            // Check if the name and time match
            if (donation['userId'] == useId &&
                formatTimestamp( donation['timestampOfBegin']) == formatTimestamp(time) &&
                donation['amountOfBags'] == amountOfBags &&
                donation['typeOfBlood'] == typeOfBlood) {
              // Update the isDone field to false

              listOfDonations[i]['isDone'] = true;
              break; // Exit loop since we found the matching donation
            }
          }
          // Update the user document with the modified listOfDonations
          userRef
              .update({'listOfBloodBags': listOfDonations})
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
  void updateIsDoneToFalseForNeedBloodBags(String nameOfDoc, useId, time, amountOfBags, typeOfBlood) {
    CollectionReference events = FirebaseFirestore.instance.collection('ourPlaces');

    // Get the document reference for the event
    DocumentReference eventRef = events.doc(nameOfDoc);

    // Update the isDone field to true for the donation at the specified index
    eventRef.get().then((eventDoc) {
      // Check if the document exists
      if (eventDoc.exists) {
        // Cast the data to a Map<String, dynamic>
        Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;

        // Retrieve listOfDonations from the eventData
        List<dynamic> listOfDonations = eventData['listOfNeedBlood'];

        // Update the isDone field of the donation at the specified index
        for (int i = 0; i < listOfDonations.length; i++) {
          // Get the current donation map
          Map<String, dynamic> donation = listOfDonations[i];

          // Check if the userId and timestamp match
          for (int i = 0; i < listOfDonations.length; i++) {
            // Get the current donation map
            Map<String, dynamic> donation = listOfDonations[i];

            // Check if the name and time match
            if (donation['userId'] == useId &&
                donation['timestampOfBegin'] == time &&
                donation['amountOfBags'] == amountOfBags &&
                donation['typeOfBlood'] == typeOfBlood) {
              // Update the isDone field to false

              listOfDonations[i]['isDone'] = false;
              break; // Exit loop since we found the matching donation
            }
          }

          // Update the event document with the modified listOfDonations
          eventRef.update({'listOfNeedBlood': listOfDonations}).then((_) {
            print("Document updated successfully");
            updateIsDoneToFalseForUserForNeedBloodBags(useId, time,amountOfBags, typeOfBlood);
          }).catchError((error) => print("Failed to update document: $error"));
        }
      } else {
        print("Event document not found.");
      }
    }).catchError((error) => print("Error getting event document: $error"));
  }
  void updateIsDoneToFalseForUserForNeedBloodBags(useId, time, amountOfBags, typeOfBlood) {
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
        if (userData != null && userData.containsKey('listOfBloodBags')) {
          // Get the list of donations from the userData
          List<dynamic> listOfDonations = userData['listOfBloodBags'];

          // Iterate through the list of donations
          for (int i = 0; i < listOfDonations.length; i++) {
            // Get the current donation map
            Map<String, dynamic> donation = listOfDonations[i];

            // Check if the name and time match
            if (donation['userId'] == useId &&
                formatTimestamp( donation['timestampOfBegin']) == formatTimestamp(time) &&
                donation['amountOfBags'] == amountOfBags &&
                donation['typeOfBlood'] == typeOfBlood) {
              // Update the isDone field to false

              listOfDonations[i]['isDone'] = false;
              break; // Exit loop since we found the matching donation
            }
          }
          // Update the user document with the modified listOfDonations
          userRef
              .update({'listOfBloodBags': listOfDonations})
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



////////////////////////////////////////////////



  String formatTimestamp(Timestamp timestamp) {
    // Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime
    String formattedDate = DateFormat.yMMMMd().add_jm().add_j().format(dateTime);

    // Add timezone information
    formattedDate += " UTC+3";

    return formattedDate;
  }

  void updateIsDoneToTrueForRegularDonation(eventId, useId, time) {
    CollectionReference events = FirebaseFirestore.instance.collection('regularDonations');
    DocumentReference eventRef = events.doc(eventId);

    eventRef.get().then((eventDoc) {
      if (eventDoc.exists) {
        Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;
        List<dynamic> listOfDonations = eventData['donations'];

        for (int i = 0; i < listOfDonations.length; i++) {
          Map<String, dynamic> donation = listOfDonations[i];
          if (donation['userId'] == useId && donation['timestampOfBegin'] == time) {
            listOfDonations[i]['isDone'] = true;
          }
        }

        eventRef.update({'donations': listOfDonations}).then((_) {
          print("Event document updated successfully");
          updateIsDoneToTrueForUserForRegularDonations(useId, time);
        }).catchError((error) => print("Failed to update event document: $error"));
      } else {
        print("Event document not found.");
      }
    }).catchError((error) => print("Error getting event document: $error"));
  }

  void updateIsDoneToTrueForUserForRegularDonations(useId, time) {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    DocumentReference userRef = usersCollection.doc(useId);

    userRef.get().then((userDoc) {
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        if (userData != null && userData.containsKey('listOfDonations')) {
          List<dynamic> listOfDonations = userData['listOfDonations'];

          for (int i = 0; i < listOfDonations.length; i++) {
            Map<String, dynamic> donation = listOfDonations[i];
            if (donation['userId'] == useId && formatTimestamp(donation['timestampOfBegin']) == formatTimestamp(time)) {
              listOfDonations[i]['isDone'] = true;
            }
          }

          userRef.update({'listOfDonations': listOfDonations}).then((_) {
            print("User document updated successfully");
          }).catchError((error) => print("Failed to update user document: $error"));
        } else {
          print("User data is missing the expected field.");
        }
      } else {
        print("User document not found.");
      }
    }).catchError((error) => print("Error getting user document: $error"));
  }
  void updateIsDoneToFalseForRegularDonation(eventId, useId, time) {
    CollectionReference events = FirebaseFirestore.instance.collection('regularDonations');
    DocumentReference eventRef = events.doc(eventId);

    eventRef.get().then((eventDoc) {
      if (eventDoc.exists) {
        Map<String, dynamic> eventData = eventDoc.data() as Map<String, dynamic>;
        List<dynamic> listOfDonations = eventData['donations'];

        for (int i = 0; i < listOfDonations.length; i++) {
          Map<String, dynamic> donation = listOfDonations[i];
          if (donation['userId'] == useId && donation['timestampOfBegin'] == time) {
            listOfDonations[i]['isDone'] = false;
          }
        }

        eventRef.update({'donations': listOfDonations}).then((_) {
          print("Event document updated successfully");
          updateIsDoneToFalseForUserForRegularDonations(useId, time);
        }).catchError((error) => print("Failed to update event document: $error"));
      } else {
        print("Event document not found.");
      }
    }).catchError((error) => print("Error getting event document: $error"));
  }

  void updateIsDoneToFalseForUserForRegularDonations(useId, time) {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    DocumentReference userRef = usersCollection.doc(useId);

    userRef.get().then((userDoc) {
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        if (userData != null && userData.containsKey('listOfDonations')) {
          List<dynamic> listOfDonations = userData['listOfDonations'];

          for (int i = 0; i < listOfDonations.length; i++) {
            Map<String, dynamic> donation = listOfDonations[i];
            if (donation['userId'] == useId && formatTimestamp(donation['timestampOfBegin']) == formatTimestamp(time)) {
              listOfDonations[i]['isDone'] = false;
            }
          }

          userRef.update({'listOfDonations': listOfDonations}).then((_) {
            print("User document updated successfully");
          }).catchError((error) => print("Failed to update user document: $error"));
        } else {
          print("User data is missing the expected field.");
        }
      } else {
        print("User document not found.");
      }
    }).catchError((error) => print("Error getting user document: $error"));
  }

}
