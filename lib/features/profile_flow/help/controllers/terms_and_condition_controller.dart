import 'package:get/get.dart';

class TermsAndConditionController extends GetxController {
  // Title of the screen (could come from localization)
  final title = 'Privacy Policy'.obs;

  // Privacy policy text - in real app you might load this from assets or network.
  final privacyText = RxString(_defaultText);

  static const String _defaultText = '''
Odio eu feugiat pretium nibh ipsum consequat nisl. Tempus quam pellentesque nec nam aliquam sem et tortor consequat. Elit eget gravida cum sociis natoque penatibus. Sed elementum tempus egestas sed sed risus. Id interdum velit laoreet id donec ultrices. Fermentum leo vel orci porta non pulvinar neque laoreet. In mollis nunc sed id semper risus in hendrerit gravida. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Erat nam at lectus urna duis convallis convallis. Interdum velit laoreet id donec ultrices tincidunt arcu. Sit amet venenatis urna cursus eget nunc scelerisque viverra. Purus in massa tempor nec feugiat. Hendrerit gravida rutrum quisque non tellus orci ac auctor augue. Aenean vel elit scelerisque mauris pellentesque.

Odio eu feugiat pretium nibh ipsum consequat nisl. Tempus quam pellentesque nec nam aliquam sem et tortor consequat. Elit eget gravida cum sociis natoque penatibus. Sed elementum tempus egestas sed sed risus. Id interdum velit laoreet id donec ultrices. Fermentum leo vel orci porta non pulvinar neque laoreet. In mollis nunc sed id semper risus in hendrerit gravida. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Erat nam at lectus urna duis convallis convallis. Interdum velit laoreet id donec ultrices tincidunt arcu.
''';

  // any other state logic can go here (e.g., loading from file)
}
