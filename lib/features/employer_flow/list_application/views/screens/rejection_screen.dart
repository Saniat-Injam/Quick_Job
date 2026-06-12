// Placeholder for a rejection screen (as requested)
import 'package:flutter/material.dart';

class RejectionScreen extends StatelessWidget {
  const RejectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rejection Sent")),
      body: Center(child: Text("Candidate feedback/rejection screen.")),
    );
  }
}
