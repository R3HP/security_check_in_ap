import 'package:flutter/material.dart';

import 'package:security_check_in/view/widgets/add_check_in_bottom_sheet.dart';

class CheckDetailScreen extends StatelessWidget {
  static const routeName = '/check_in_detail';

  const CheckDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    final checkIn = args['check_in'];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
        ],
        centerTitle: true,
        title: const Text('اطلاعات ورود'),
      ),
      body: AddCheckInBottomSheet(isEditing: true,checkIn: checkIn,),
    );
  }
}
