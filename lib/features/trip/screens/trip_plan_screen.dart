import 'package:flutter/material.dart';

class TripPlanScreen extends StatefulWidget {
  const TripPlanScreen({super.key});

  @override
  State<TripPlanScreen> createState() => _TripPlanScreenState();
}

class _TripPlanScreenState extends State<TripPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Plan'),
      ),
      body: const Center(
        child: Text('Trip Plan Screen'),
      ),
    );
  }
}