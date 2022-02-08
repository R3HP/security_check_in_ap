import 'package:flutter/material.dart';

class SuccessSnackBar extends SnackBar {
  SuccessSnackBar({ Key? key , String? message }) : super(key: key,content: Text(message ?? 'عملیات موفق بود' , style: const TextStyle(color: Colors.white),),backgroundColor: Colors.green,shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))));
}