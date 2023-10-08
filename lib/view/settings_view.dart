import 'package:cligo/features/screen_size.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.colorDim4,
        appBar: AppBar(
          title: const Text(
            "Setări",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Pallete.colorDim4,
        ),
        body:  Column(
          children: [
            //settings
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: SizedBox(
                width: ScreenSize(context).width,
                height: ScreenSize(context).height * 0.08,
                child: TextButton(
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Pallete.colorDim0,
                      ),
                      Padding(padding: EdgeInsets.only(right: 5.0)),
                      Text(
                        'idk',
                        style: TextStyle(
                          color: Pallete.colorDim0,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),//settings
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: SizedBox(
                width: ScreenSize(context).width,
                height: ScreenSize(context).height * 0.08,
                child: TextButton(
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Pallete.colorDim0,
                      ),
                      Padding(padding: EdgeInsets.only(right: 5.0)),
                      Text(
                        'idk',
                        style: TextStyle(
                          color: Pallete.colorDim0,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),//settings
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: SizedBox(
                width: ScreenSize(context).width,
                height: ScreenSize(context).height * 0.08,
                child: TextButton(
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Pallete.colorDim0,
                      ),
                      Padding(padding: EdgeInsets.only(right: 5.0)),
                      Text(
                        'idk',
                        style: TextStyle(
                          color: Pallete.colorDim0,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}