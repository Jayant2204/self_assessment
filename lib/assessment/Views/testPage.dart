import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_assessment/assessment/controller/testController.dart';
import 'package:self_assessment/assessment/widgets/testquestionWidget.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TestController controller = TestController();
  @override
  void initState() {
    // Call Api to fetch new Questions. Mock API Fetch
    controller.getAssessment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: RaisedButton(
        onPressed: () {
          print(controller.submittedAnswers);
        },
        color: Colors.blue,
        padding: EdgeInsets.zero,
        child: Text("Submit"),
      ),
      body: Obx(() => Container(
            child: controller.assessment.value != null
                ? CarouselSlider.builder(
                    itemCount:
                        controller.assessment.value?.questions?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TestQuestionWidget(
                        question: controller.assessment.value.questions[index],
                        index: index,
                        onSelectAnswer: controller.onAnswerSelected,
                        previouslySelectedAnswer:
                            controller.submittedAnswers[index],
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      aspectRatio: 3 / 4,
                      enableInfiniteScroll: false,
                    ))
                : Container(color: Colors.red),
          )),
    );
  }
}
