import 'package:flutter/material.dart';
import 'package:morostick/features/auth/web_view/logic/web_view_cubit.dart';
import 'package:morostick/features/auth/web_view/logic/web_view_state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    final cubit = context.read<WebViewCubit>();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            cubit.setProgress(progress / 100.0);
          },
          onPageStarted: (String url) {
            cubit.setLoading(true);
          },
          onPageFinished: (String url) {
            cubit.setLoading(false);
          },
          onHttpError: (HttpResponseError error) {
            cubit.setError(true);
          },
          onWebResourceError: (WebResourceError error) {
            cubit.setError(true);
          },
        ),
      );

    if (cubit.state.url.isNotEmpty) {
      controller.loadRequest(Uri.parse(cubit.state.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebViewCubit, WebViewState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 46.h,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: state.hasError
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Center(
                              child: Text(
                                "Sorry something went wrong, Please try again later...",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : WebViewWidget(controller: controller),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withValues(alpha: 0.1),
                              offset: const Offset(0, 20),
                              spreadRadius: -10,
                              blurRadius: 16,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: Icon(Icons.arrow_back),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              context.watch<WebViewCubit>().state.title,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.progress < 1.0)
                  Positioned(
                    top: 50,
                    child: Container(
                      width: MediaQuery.of(context).size.width * state.progress,
                      height: 2,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(52)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
