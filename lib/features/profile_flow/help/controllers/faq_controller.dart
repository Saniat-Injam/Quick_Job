import 'package:get/get.dart';
import '../models/faq_model.dart';

class FaqController extends GetxController {
  final faqList = <FaqModel>[
    FaqModel(
      question: 'What is DMVJOBS.ai?',
      answer: 'DMVJOBS.ai is a smart job portal platform.',
    ),
    FaqModel(
      question: 'How to use DMVJOBS.ai?',
      answer: 'Create an account, search jobs, and apply easily.',
    ),
    FaqModel(
      question: 'Is DMVJOBS.ai safe for me?',
      answer: 'Yes, your data is secured with industry standards.',
    ),
    FaqModel(
      question: 'How to apply a job on DMVJOBS.ai?',
      answer: 'Open a job post and click on the apply button.',
    ),
    FaqModel(
      question: 'How to logout from DMVJOBS.ai?',
      answer: 'Go to profile settings and tap logout.',
    ),
    FaqModel(
      question: 'Is there a tips for get a better job?',
      answer: 'Complete your profile and apply regularly.',
    ),
    FaqModel(
      question: 'Is DMVJOBS.ai free to use?',
      answer: 'Yes, DMVJOBS.ai is completely free for job seekers.',
    ),
  ].obs;

  void toggleExpansion(int index) {
    faqList[index].isExpanded = !faqList[index].isExpanded;
    faqList.refresh();
  }
}
