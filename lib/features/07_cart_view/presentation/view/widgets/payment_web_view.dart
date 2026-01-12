import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_2025/core/utilities/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String url; // رابط الـ iframe (اللي بترجعه Paymob)
  final Function(bool success) onResult; // ترجع حالة الدفع: true / false

  const PaymentWebView({super.key, required this.url, required this.onResult});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController controller;
  bool _handle = false;
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            _handleRedirect(request.url);
            return NavigationDecision.navigate;
          },
          onPageStarted: _handleRedirect,
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  // هنا نتابع كل URL يفتحه الـ WebView علشان نعرف الدفع نجح ولا لأ
  void _handleRedirect(String url) {
    debugPrint("🔍 Back URL => $url");
    if (_handle) return;
    if (url.contains('success=true')) {
      _handle = true;
      widget.onResult(true);
    }

    if (url.contains('success=false')) {
      _handle = false;
      widget.onResult(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('now in web view');
    return Scaffold(
      appBar: customAppBar(context, 'Payment', () {
        Navigator.pop(context);
      }),
      body: WebViewWidget(controller: controller),
    );
  }
}
