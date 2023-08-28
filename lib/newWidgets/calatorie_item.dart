import 'package:flutter/material.dart';
import 'package:cligo/constants/colors.dart';

class CalatorieItem extends StatefulWidget {
  const CalatorieItem({Key? key}) : super(key: key);

  @override
  State<CalatorieItem> createState() => _CalatorieItemState();
}

class _CalatorieItemState extends State<CalatorieItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 2, color: Colors.white54),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white54, Colors.white10],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ClipRRect(
                  // Adding ClipRRect for circular shape
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white30, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color.fromARGB(255, 200, 200, 200),
                      backgroundImage:
                          AssetImage('lib/assets/images/default_avatar.png'),
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 80),
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text(
                        'Ciocan Daniel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Pallete.textColor,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 180),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Nisporeni - Cluj",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Pallete.textColor)),
                    ),
                  ),
                ),
                const Text('2 locuri',
                    style: TextStyle(fontSize: 16, color: Pallete.textColor)),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    "12",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Pallete.textColor),
                  ),
                  Text(
                    'august',
                    style: TextStyle(fontSize: 16, color: Pallete.textColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
