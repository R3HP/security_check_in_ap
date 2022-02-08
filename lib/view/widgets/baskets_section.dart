import 'package:flutter/material.dart';

class BasketsSection extends StatelessWidget {
  const BasketsSection({
    Key? key,
    required TextEditingController prepackController,
    required TextEditingController farahmandController,
  }) : _prepackController = prepackController, _farahmandController = farahmandController, super(key: key);

  final TextEditingController _prepackController;
  final TextEditingController _farahmandController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).colorScheme.primary),
          child: Column(
            children: [
              FittedBox(
                child: FittedBox(
                  child: Text(
                    'تعداد سبد های پری پک',
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary),
                  ),
                ),
              ),
              TextField(
                controller: _prepackController,
                textAlign: TextAlign.center,
                maxLength: 4,
                buildCounter: (context,
                        {int? currentLength,
                        bool? isFocused,
                        maxLength}) =>
                    null,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color:
                          Theme.of(context).colorScheme.secondary),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '0',
                  contentPadding: const EdgeInsets.all(5.0),
                  border: const OutlineInputBorder(
                    gapPadding: 5,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        )),
        const VerticalDivider(
          width: 40,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Theme.of(context).colorScheme.primary),
            child: Column(
              children: [
                FittedBox(
                  child: Text(
                    'تعداد سبدهای فرهمند',
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary),
                  ),
                ),
                TextField(
                  controller: _farahmandController,
                  textAlign: TextAlign.center,
                  maxLength: 4,
                  buildCounter: (context,
                          {int? currentLength,
                          bool? isFocused,
                          int? maxLength}) =>
                      null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary),
                    hintText: '0',
                    contentPadding: const EdgeInsets.all(5.0),
                    border: const OutlineInputBorder(
                      gapPadding: 5,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.previous,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
