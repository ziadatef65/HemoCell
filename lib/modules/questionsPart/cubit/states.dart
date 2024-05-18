
abstract class AddQuestionsStates{}

class AddQuestionsInitialState extends AddQuestionsStates{}



class  AddQuestionsLoadingState extends AddQuestionsStates{}
class  AddQuestionsSuccessfullyState extends AddQuestionsStates{}
class  AddQuestionsErrorState extends AddQuestionsStates{
  final String error;
  AddQuestionsErrorState(this.error);
}

class ChangeIndexSuccessfullyState extends AddQuestionsStates{}
class ChangeIndexErrorState extends AddQuestionsStates{}


