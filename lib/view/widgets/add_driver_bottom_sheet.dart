import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:security_check_in/view/widgets/car_lisence_plate_widget.dart';
import 'package:security_check_in/view/widgets/failure_snackbar.dart';
import 'package:security_check_in/view/widgets/success_snackbar.dart';
import 'package:security_check_in/view_model/driver_view_model.dart';

class AddDriverBottomSheet extends StatefulWidget {
  const AddDriverBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddDriverBottomSheet> createState() => _AddDriverBottomSheetState();
}

class _AddDriverBottomSheetState extends State<AddDriverBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameContoller = TextEditingController();

  final TextEditingController _carController = TextEditingController();

  final StringBuffer _stringBuffer = StringBuffer();

  String? driverPhotoPath;

  File? driverImageFile;

  @override
  void dispose() {
    _nameContoller.dispose();
    _carController.dispose();
    _stringBuffer.clear();
    driverPhotoPath = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 2),
        curve: Curves.ease,
        padding: MediaQuery.of(context).viewInsets,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('نام و نام خانوادگی :'),
                  ),
                  controller: _nameContoller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'لطفا نام را وارد کند';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('مدل خودرو : '),
                  ),
                  controller: _carController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'لطفا نام را وارد کند';
                    }
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text('پلاک خودرو :'),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CarLicensePlate(
                        width: 250,
                        height: 70,
                        stringBuffer: _stringBuffer,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
                      child: IconButton(
                        color: Theme.of(context).colorScheme.onPrimary,
                        iconSize: 30,
                        onPressed: () async {
                          final xfile = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                            maxHeight: 300,
                          );
                          driverImageFile = File(xfile!.path);
                        },
                        icon: const Icon(Icons.camera_alt_rounded),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary),
                      child: IconButton(
                        color: Theme.of(context).colorScheme.onPrimary,
                        iconSize: 30,
                        splashColor: Colors.indigo,
                        onPressed: () async {
                          final xfile = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 300,
                          );
                          driverImageFile = File(xfile!.path);
                        },
                        icon: const Icon(
                          Icons.storage_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: submitNewDriver,
                    child: const Text('ثبت راننده '))
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitNewDriver() async {
    if (_formKey.currentState!.validate()) {
      if (driverImageFile != null) {
        final downloadDir = Directory('/storage/emulated/0/Download');
        final downloadDirCheckInDir =
            await Directory(downloadDir.path + '/CheckIn')
                .create(recursive: true);
        final photo = await File(
                downloadDirCheckInDir.path+ '/' + _nameContoller.text + '.jpg')
            .writeAsBytes(await driverImageFile!.readAsBytes());
        driverPhotoPath = photo.path;
      }
      context
          .read<DriverViewModel>()
          .createNewDriverAndAddToDatabase(
              _nameContoller.text,
              _carController.text,
              _stringBuffer.toString(),
              driverPhotoPath ?? '')
          .then((value) => Navigator.of(context).pop())
          .then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar()))
          .catchError((failure) =>
              ScaffoldMessenger.of(context).showSnackBar(FailureSnackBar()));
    }
  }
}
