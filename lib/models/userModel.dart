class UserModel {
  String? name;
  String? email;
  String? phone;
  String? userId;
  bool? isAdmin;
  int? numberOfBloodDonations;
  int? numberOfBloodRecipient;
  List? listOfDonations;
  List? listOfBloodBags;
  List? listOfBloodByEvent;
  List? listOfQuestions;


  UserModel({
    this.phone,
    this.email,
    this.name,
    this.userId,
    this.isAdmin,
    this.numberOfBloodDonations,
    this.numberOfBloodRecipient,
    this.listOfDonations,
    this.listOfBloodBags,
    this.listOfBloodByEvent,
    this.listOfQuestions,

  });

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userId = json['userId'];
    isAdmin = json['isAdmin'];
    numberOfBloodDonations = json['numberOfBloodDonations'];
    numberOfBloodRecipient = json['numberOfBloodRecipient'];
    listOfDonations = json['listOfDonations'];
    listOfBloodBags = json['listOfBloodBags'];
    listOfBloodByEvent = json['listOfBloodByEvent'];
    listOfQuestions = json['listOfQuestions'];


  }


  Map<String,dynamic> toMap()
  {
    return {
      'email':email,
      'name':name,
      'phone':phone,
      'userId':userId,
      'isAdmin':isAdmin,
      'numberOfBloodDonations':numberOfBloodDonations,
      'numberOfBloodRecipient':numberOfBloodRecipient,
      'listOfDonations':listOfDonations,
      'listOfBloodBags':listOfBloodBags,
      'listOfBloodByEvent':listOfBloodByEvent,
      'listOfQuestions':listOfQuestions,
    };
  }

}
