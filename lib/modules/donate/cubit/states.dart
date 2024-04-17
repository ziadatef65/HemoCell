
abstract class DonateBloodStates{}

class DonateBloodInitialState extends DonateBloodStates{}



class CreateVoteLoadingState extends DonateBloodStates{}
class CreateVoteSuccessfullyState extends DonateBloodStates{}
class CreateVoteErrorState extends DonateBloodStates{
  final String error;
  CreateVoteErrorState(this.error);
}



class ChooseTeamSuccessfully extends DonateBloodStates{}
class DeleteTeamSuccessfully extends DonateBloodStates{}

class ChooseRefereeSuccessfully extends DonateBloodStates{}
class DeleteRefereeSuccessfully extends DonateBloodStates{}


class ChooseScoreSuccessfully extends DonateBloodStates{}
class ClearDataSuccessfully extends DonateBloodStates{}