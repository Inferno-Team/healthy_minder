import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_minder/ui/home/home_viewmodel.dart';

class homepage extends GetView<homeViewModel> {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController UserNameEmail = TextEditingController();
    TextEditingController PassWord = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return Scaffold();
  }
}
