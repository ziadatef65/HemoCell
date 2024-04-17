
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemo_cell/admin/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/eventsModel.dart';

class AdminCubit extends Cubit<AdminStates>{
  AdminCubit(): super(AdminInitialState());
  static AdminCubit get(context) => BlocProvider.of(context);
  EventModel? eventModel;

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(EventImagePickedSuccessState());
    }else{
      print('No image selected.');
      emit(EventImagePickedErrorState());
    }
  }
  deleteEventImage(){
    profileImage = null;
    emit(DeleteEventImageSuccessState());
  }
  //////////////////////////////////////////////////////////////////
  void uploadProfileImage(
      String? nameOfEvent,
      )
  {
    emit(UploadImageOfEventLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('events/${Uri.file(profileImage!.path).pathSegments.last}').putFile(profileImage!).then((value){
      value.ref.getDownloadURL().then((dynamic value) {
        emit(UploadImageOfEventLoadingState());
        updateEventImage(
          nameOfEvent: nameOfEvent,
          imageOfEvent:value,
        );
      }).then((value){
        emit(UploadProfileImageSuccessState());

      });
    }).catchError((error){
      emit(UploadProfileImageSuccessState());
    });
  }
  //////////////////////////////////////
  void eventCreate({
    required String nameOfEvent,
    String? image,
  }){

    EventModel model = EventModel(
      nameOfEvent: nameOfEvent,
      imageOfEvent:'https://img.freepik.com/free-vector/error-404-concept-landing-page_52683-21190.jpg',
    );
    emit(CreateEventLoadingState(nameOfEvent));
    FirebaseFirestore.instance
        .collection('events')
        .doc(nameOfEvent).set(model.toMap()).then((value) {
      emit(CreateEventSuccessState(nameOfEvent));
    }).catchError((error){
      emit(CreateEventErrorState(error));
    });
  }
  /////////////////////////
  void updateEventImage({
    String? nameOfEvent,
    String? imageOfEvent,
  })
  {
    emit(UploadImageOfEventLoadingState());
    EventModel model = EventModel(
      nameOfEvent: nameOfEvent,
      imageOfEvent:imageOfEvent?? eventModel!.imageOfEvent,
      target: 0,
      lisOfDonations: [],
        usersId:[],
    );

    FirebaseFirestore.instance.collection('events').doc(nameOfEvent).update(model.toMap()).then((dynamic value) {
      eventModel!.imageOfEvent = value;
      emit(UploadImageOfEventSuccessState());
    }).catchError((error){
      emit(UploadImageOfEventSuccessState());
    });
  }
///////////////////////////
  void deleteEventFromFireBase(nameOfEvent){
    FirebaseFirestore.instance.collection('events').doc(nameOfEvent).delete().then((value) {
      emit(DeleteEventSuccessState());
    }).catchError(
            (error){
              emit(DeleteEventErrorState());
            }
    );
  }



////////////////////////////////////
  final CollectionReference detailRef =
  FirebaseFirestore.instance.collection('events');
  void addDetailsOfEvent(String nameOfEvent,String detail,) async {
    emit(AddDetailsOfEventLoadingState());
    await detailRef
        .doc(nameOfEvent)
        .update({'details': detail }).then((value){
      emit(AddDetailsOfEventSuccessState());
    }).catchError((error){
      emit(AddDetailsOfEventErrorState());
    });
  }

  ///////////////////////////////////////
  final CollectionReference targetRef =
  FirebaseFirestore.instance.collection('events');
  void addTargetOfEvent(String nameOfEvent,dynamic target,) async {
    emit(AddTargetOfEventLoadingState());
    await targetRef
        .doc(nameOfEvent)
        .update({'fixedTarget': target}).then((value){
      emit(AddTargetOfEventSuccessState());
    }).catchError((error){
      emit(AddTargetOfEventErrorState());
    });
  }

//////////////////////////////////////////
  addInformation(nameOfEvent,detail,fixedTarget){
    addTargetOfEvent(nameOfEvent, fixedTarget);
    addDetailsOfEvent(nameOfEvent, detail);
    emit(DoneAddInfoSuccessState());
  }
///////////////////



}