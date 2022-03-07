import 'Page/chat_page.dart';
import 'Page/home_page.dart';

class PageController {
    static int currentBarIndex = 0;

    static var pageId = const {
        0: HomePage(),
        1: ChatPage(),
    };
}