
abstract class DonateBloodStates{}

class DonateBloodInitialState extends DonateBloodStates{}



class DonateByEventLoadingState extends DonateBloodStates{}
class DonateByEventSuccessfullyState extends DonateBloodStates{}
class DonateByEventErrorState extends DonateBloodStates{
  final String error;
  DonateByEventErrorState(this.error);
}




