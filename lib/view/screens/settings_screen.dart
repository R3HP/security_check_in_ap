import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_check_in/view_model/theme_view_model.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('تنظیمات'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text('رنگ دلخواه خود را انتخاب کنید '),
          ),
          SizedBox(
            height: 100,
            child: Consumer<ThemeViewModel>(
              builder: (context, themeViewModel, child) => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: themeViewModel.colors.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      themeViewModel.changeThemeColor(index);
                    },
                    child: CircleAvatar(
                        backgroundColor: themeViewModel.colors[index],
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        child: index == themeViewModel.index
                            ? const Icon(Icons.check)
                            : null),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
