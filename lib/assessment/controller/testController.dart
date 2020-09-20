import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_assessment/assessment/Data/questions.dart';
import 'package:self_assessment/global/constants.dart';

class TestController extends GetxController {
  final assessment = Assessment().obs;
  final submittedAnswers = Map<String, String>().obs;
  final obtainedMarks = 0.obs;
  final correctAnswers = 0.obs;
  final incorrectAnswers = 0.obs;

  answerIsCorrect() {
    this.correctAnswers.value++;
    this.obtainedMarks.value = this.obtainedMarks.value + 3;
  }

  answerIsWrong() {
    this.incorrectAnswers.value++;
    this.obtainedMarks.value = this.obtainedMarks.value - 1;
  }

  onAnswerSelected(String index, String selectedAnswer) {
    if (this.submittedAnswers.containsKey(index)) {
      this.submittedAnswers.remove(index);
    }
    this.submittedAnswers.add(index, selectedAnswer);
  }

  getAssessment() async {
    GetStorage box = GetStorage();
    var data = box.read(Constants.assessmentOfDayKey);
    if (data == null ||
        (data["status"] &&
            (DateTime.parse(data["date"]).day != DateTime.now().day ||
                DateTime.parse(data["date"]).month != DateTime.now().month ||
                DateTime.parse(data["date"]).year != DateTime.now().year))) {
      // Mock API call
      fetchAssessmentFromApi();
      Map<String, dynamic> dateAndViewMap = Map();
      dateAndViewMap = {
        "date": DateTime.now().toIso8601String(),
        "status": false,
      };
      box.write(Constants.assessmentOfDayKey, dateAndViewMap);
    } else {
      fetchAssessmentFromLocalData();
    }
  }

  fetchAssessmentFromApi() async {
    var result = await rootBundle.loadString("assets/questions.json");
    Future.delayed(Duration(seconds: 1)).then(
        (value) => this.assessment.value = Assessment.fromRawJson(result));
  }

  fetchAssessmentFromLocalData() async {
    var result = await rootBundle.loadString("assets/questions.json");
    this.assessment.value = Assessment.fromRawJson(result);
  }

  getTotalMarks() {
    var userAnswers = this.submittedAnswers;

    var questionList = this.assessment.value.questions;

    questionList.forEach((element) {
      if (userAnswers[element.qId] == element.answerId) {
        answerIsCorrect();
      } else {
        answerIsWrong();
      }
    });

    // userAnswers.forEach((element) {
    //   if (questionList[element.key].answerId == element.value) {
    //     answerIsCorrect();
    //   } else {
    //     answerIsWrong();
    //   }
    // });
  }
}
