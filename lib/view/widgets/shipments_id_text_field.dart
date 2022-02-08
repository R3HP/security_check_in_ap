import 'package:flutter/material.dart';

class ShipmentsIdTextField extends StatefulWidget {
  final List<int> shipmentIds;
  final GlobalKey<FormState> shipmentFormKey;
  const ShipmentsIdTextField({
    Key? key,
    required this.shipmentIds,
    required this.shipmentFormKey,
  }) : super(key: key);

  @override
  _ShipmentsIdTextFieldState createState() => _ShipmentsIdTextFieldState();
}

class _ShipmentsIdTextFieldState extends State<ShipmentsIdTextField> {
  int numberOfTextFields = 1;
  // Map<int, TextEditingController> controllerMap = {};
  late List<int> shipmentId;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    shipmentId = widget.shipmentIds;
    numberOfTextFields =
        widget.shipmentIds.isEmpty ? 1 : widget.shipmentIds.length;
  }

  @override
  Widget build(BuildContext context) {
    // for (var i = 0; i < numberOfTextFields; i++) {
    //   controllerMap.putIfAbsent(
    //     i,
    //     () => TextEditingController(
    //       text: widget.shipmentIds.isEmpty
    //           ? null
    //           : widget.shipmentIds[i].toString(),
    //     ),
    //   );
    // }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      height: numberOfTextFields < 4
          ? 60.0 * numberOfTextFields + 50
          : 60.0 * 4 + 30,
      width: 120,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: widget.shipmentFormKey,
              child: ListView.separated(
                // controller: scrollController,
                separatorBuilder: (context, index) => const Divider(
                  height: 8,
                ),
                itemCount: numberOfTextFields,
                itemBuilder: (ctx, index) => TextFormField(
                  buildCounter: (context,
                          {int? currentLength, bool? isFocused, maxLength}) =>
                      null,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  textAlign: TextAlign.center,
                  initialValue: index > widget.shipmentIds.length - 1
                      ? null
                      : widget.shipmentIds.elementAt(index).toString(),
                  onSaved: (newValue) {
                    if (index == 0) {
                      widget.shipmentIds.clear();
                    }
                    if (newValue != null && newValue != "") {
                      widget.shipmentIds.add(int.parse(newValue));
                    }
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: '0000', fillColor: Theme.of(context).colorScheme.onPrimary, filled: true),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: IconButton(
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: () {
                    setState(() {
                      numberOfTextFields += 1;
                    });
                    // scrollController.jumpTo(numberOfTextFields.toDouble());
                  },
                  icon: const Icon(Icons.add_rounded)),
            ),
          )
        ],
      ),
    );
  }
}
