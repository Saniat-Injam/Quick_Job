import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/custom_appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class SeeResumeScreen extends StatelessWidget {
  const SeeResumeScreen({super.key, this.pdfUrl});
  final String? pdfUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen PDF
          Positioned.fill(
            child: SfPdfViewerTheme(
              data: const SfPdfViewerThemeData(backgroundColor: Colors.white),
              child: (pdfUrl ?? "").isNotEmpty
                  ? SfPdfViewer.network(
                      pdfUrl ?? "",
                      pageSpacing: 0,
                      enableDoubleTapZooming: true,
                      enableTextSelection: true,
                      canShowScrollHead: false,
                      canShowScrollStatus: false,
                      pageLayoutMode: PdfPageLayoutMode.single,
                    )
                  : SfPdfViewer.asset(
                      "assets/images/me.pdf",
                      pageSpacing: 0,
                      enableDoubleTapZooming: true,
                      enableTextSelection: true,
                      canShowScrollHead: false,
                      canShowScrollStatus: false,
                      pageLayoutMode: PdfPageLayoutMode.single,
                    ),
            ),
          ),

          // App bar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: const CustomAppBar(
                backgroundColor: Colors.transparent,
                title: "See Resume",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
