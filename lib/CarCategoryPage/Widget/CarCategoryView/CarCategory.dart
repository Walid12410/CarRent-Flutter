import 'package:flutter/material.dart';


class CarCategoryView extends StatefulWidget {
  const CarCategoryView({super.key , required this.categoryId});

  final String categoryId;

  @override
  State<CarCategoryView> createState() => _CarCategoryViewState();
}

class _CarCategoryViewState extends State<CarCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Text(widget.categoryId),
        ),
      ),
    );
  }
}
