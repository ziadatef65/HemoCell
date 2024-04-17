import 'package:cloud_firestore/cloud_firestore.dart';

class DonateModel2 {

  String? name;
  int? age;
  int? periodOfDonatedBefore;
  String? gender;
  String? donateBloodBefore;
  String? chronicDiseases;
  String? userId;
  String? nameOfEvent;
  Timestamp? timestampOfBegin;

  DonateModel2({
    this.name,
    this.age,
    this.gender,
    this.periodOfDonatedBefore,
    this.donateBloodBefore,
    this.chronicDiseases,
    this.userId,
    this.nameOfEvent,

    this.timestampOfBegin,

  });

  DonateModel2.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    userId = json['userId'];
    donateBloodBefore = json['Donate blood before'];
    chronicDiseases = json['Chronic diseases'];
    periodOfDonatedBefore = json['Period of donated before'];
    timestampOfBegin = json['timestampOfBegin'];
    nameOfEvent = json['nameOfEvent'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'Donate blood before': donateBloodBefore,
      'Chronic diseases': chronicDiseases,
      'Period of donated before': periodOfDonatedBefore,
      'timestampOfBegin': timestampOfBegin,
      'userId': userId,
      'nameOfEvent': nameOfEvent,

    };
  }
}
