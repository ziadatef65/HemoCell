class EventModel
{
  String? nameOfEvent;
  String?  imageOfEvent;
  String?  details;
  int? target;
  int? fixedTarget;
  List? lisOfDonations;
  List? usersId;





  EventModel({
    this.nameOfEvent,
    this.imageOfEvent,
    this.details,
    this.target,
    this.fixedTarget,
    this.lisOfDonations,
    this.usersId,


  });


  EventModel.fromJson(Map<dynamic,dynamic> json)
  {

    nameOfEvent = json['nameOfEvent'];
    imageOfEvent= json['imageOfEvent'];
    details= json['details'];
    target= json['target'];
    fixedTarget= json['fixedTarget'];
    lisOfDonations= json['lisOfDonations'];
    usersId= json['usersId'];



  }

  Map<String,dynamic> toMap()
  {
    return{
      'nameOfEvent':nameOfEvent,
      'imageOfEvent':imageOfEvent,
      'details':details,
      'target':target,
      'fixedTarget':fixedTarget,
      'lisOfDonations':lisOfDonations,
      'usersId':usersId,



    };
  }


}