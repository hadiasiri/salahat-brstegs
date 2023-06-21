import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewProv with ChangeNotifier {
  WebViewController? webViewController, webViewControllerCopy;
  setWebViewCtrl(WebViewController? ctrl) {
    webViewController = ctrl;
    notifyListeners();
  }

  setWebViewCtrlCopy(WebViewController? ctrl) {
    webViewControllerCopy = ctrl;
    notifyListeners();
  }

  resetCtrl() {
    webViewController?.loadRequest(
      Uri.parse('https://saleh.tech-view.site/1index.php'),
    );
  }

  resetCtrlCopy() {
    webViewControllerCopy?.loadRequest(
      Uri.parse('https://google.com'),
    );
  }
}
