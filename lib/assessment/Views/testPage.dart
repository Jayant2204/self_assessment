import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_assessment/assessment/Views/assessiment.dart';
import 'package:self_assessment/assessment/controller/testController.dart';
import 'package:self_assessment/assessment/widgets/testquestionWidget.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  CarouselController carouselController = CarouselController();
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
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () => Get.snackbar("Self Assessment Rules",
                  "Correct answer = 3 marks, Wrong answer = -1",
                  backgroundColor: Colors.grey[600],
                  margin: EdgeInsets.all(10),
                  snackPosition: SnackPosition.TOP))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.getTotalMarks();
          Get.offAll(AssessmentPage(controller: controller));
        },
        label: Text("Submit"),
      ),
      persistentFooterButtons: [
        FlatButton(
            onPressed: () => carouselController.previousPage(
                duration: Duration(milliseconds: 400)),
            child: Text("Previous")),
        FlatButton(
            onPressed: () => carouselController.nextPage(
                duration: Duration(milliseconds: 400)),
            child: Text("Next")),
      ],
      body: Obx(() => Container(
            child: controller.assessment.value != null
                ? CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount:
                        controller.assessment.value?.questions?.length ?? 0,
                    itemBuilder: (context, index) {
                      return new TestQuestionWidget(
                        question: controller.assessment.value.questions[index],
                        index: index,
                        onSelectAnswer: controller.onAnswerSelected,
                        controller: controller,
                      );
                    },
                    options: CarouselOptions(
                      carouselController: carouselController,
                      viewportFraction: 1,
                      aspectRatio: 0.6,
                      enableInfiniteScroll: false,
                    ))
                : Container(
                    child: Center(child: CircularProgressIndicator()),
                  ),
          )),
    );
  }
}
