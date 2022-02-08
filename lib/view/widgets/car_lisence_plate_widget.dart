import 'package:flutter/material.dart';

class CarLicensePlate extends StatefulWidget {
  final double width;
  final double height;
  final String? carId;
  final StringBuffer? stringBuffer;

  const CarLicensePlate({
    Key? key,
    required this.width,
    required this.height,
    this.carId,
    this.stringBuffer,
  }) : super(key: key);

  @override
  State<CarLicensePlate> createState() => _CarLicensePlateState();
}

class _CarLicensePlateState extends State<CarLicensePlate> {
  FocusNode? _firstNode;

  TextEditingController? _firstController;

  FocusNode? _secondNode;

  TextEditingController? _secondController;

  FocusNode? _thirdNode;

  TextEditingController? _thirdController;

  FocusNode? _fourthNode;

  TextEditingController? _fourthController;

  // StringBuffer sb = StringBuffer();

  @override
  void dispose() {
    if (widget.carId == null) {
      _firstNode?.removeListener(() {});
      _firstNode?.dispose();
      _firstController?.removeListener(() {});
      _firstController?.dispose();

      _secondNode?.removeListener(() {});
      _secondNode?.dispose();
      _secondController?.removeListener(() {});
      _secondController?.dispose();

      _thirdNode?.removeListener(() {});
      _thirdNode?.dispose();
      _thirdController?.removeListener(() {});
      _thirdController?.dispose();

      _fourthNode?.removeListener(() {});
      _fourthNode?.dispose();
      _fourthController?.removeListener(() {});
      _fourthController?.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.carId == null) {
      _firstNode = FocusNode();
      _secondNode = FocusNode();
      _thirdNode = FocusNode();
      _fourthNode = FocusNode();

      _firstController = TextEditingController();
      _secondController = TextEditingController();
      _thirdController = TextEditingController();
      _fourthController = TextEditingController();
    }
    _firstNode?.addListener(() {
      if (!_firstNode!.hasFocus) {
        widget.stringBuffer!.clear();
        // sb.clear();
        widget.stringBuffer!.write(_firstController?.text);
        // sb.write(_firstController.text);
      }
    });

    _secondNode?.addListener(() {
      if (!_secondNode!.hasFocus) {
        widget.stringBuffer!.write(_secondController?.text);
        // sb.write(_secondController.text);
      }
    });
    _thirdNode?.addListener(() {
      if (!_thirdNode!.hasFocus) {
        widget.stringBuffer!.write(_thirdController?.text);
        // sb.write(_thirdController.text);
      }
    });
    _fourthNode?.addListener(() {
      if (!_fourthNode!.hasFocus) {
        widget.stringBuffer!.write(_fourthController?.text);
        // sb.write(_fourthController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/car_license_plate_bg.png',
            ),
            fit: BoxFit.fill,
          ),
        ),

        child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: widget.carId == null ? Container(
                        width: widget.width * 0.2,
                        padding: const EdgeInsets.only(
                          left: 17,
                        ),
                        child: TextField(
                          controller: _firstController,
                          focusNode: _firstNode,
                          maxLength: 2,
                          buildCounter: (context,
                                  {int? currentLength,
                                  bool? isFocused,
                                  int? maxLength}) =>
                              null,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(hintText: '00'),
                          onChanged: (value) {
                            if (value.length == 2) {
                              _secondNode?.requestFocus();
                            }
                          },
                        ) ,
                        
                      ) : Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(widget.carId!.substring(0,2)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: widget.carId == null ?  Container(
                        width: widget.width * 0.1,
                        padding: const EdgeInsets.only(
                            left: 5, bottom: 5.0, top: 5.0),
                        child:TextField(
                          controller: _secondController,
                          focusNode: _secondNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          maxLength: 1,
                          buildCounter: (context,
                                  {int? currentLength,
                                  bool? isFocused,
                                  int? maxLength}) =>
                              null,
                          decoration: const InputDecoration(hintText: 'م'),
                          onChanged: (value) {
                            if (value.length == 1) {
                              _thirdNode?.requestFocus();
                            }
                          },
                        ),
                      )  : Padding(
                        padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                        child: Text(widget.carId!.substring(2,3)),
                      ) ,
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: widget.carId == null ? SizedBox(
                        width: widget.width * 0.3,
                        // padding: const EdgeInsets.only(),
                        child:TextField(
                          controller: _thirdController,
                          focusNode: _thirdNode,
                          maxLength: 3,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          buildCounter: (context,
                                  {int? currentLength,
                                  bool? isFocused,
                                  int? maxLength}) =>
                              null,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: '000',
                          ),
                          onChanged: (value) {
                            if (value.length == 3) {
                              _fourthNode?.requestFocus();
                            }
                          },
                        ),
                      )  : Text(widget.carId!.substring(3,6)) ,
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: widget.carId == null ? Container(
                        width: widget.width * 0.2,
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        child:TextField(
                          
                          controller: _fourthController,
                          focusNode: _fourthNode,
                          maxLength: 2,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          buildCounter: (context,
                                  {int? currentLength,
                                  bool? isFocused,
                                  int? maxLength}) =>
                              null,
                          decoration: const InputDecoration(
                            hintText: '00',
                          ),
                          onChanged: (value) {
                            if (value.length == 2) {
                              _fourthNode?.unfocus();
                            }
                          },
                        ),
                      )  : Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(widget.carId!.substring(6)),
                      ) ,
                    ),
                  )
                ],
              )
            ,

        
      ),
    );
  }
}
