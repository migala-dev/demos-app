import 'package:flutter/material.dart';

class OptionResultWidget extends StatelessWidget {
  final String optionName;
  final int votesCount;
  final int votesTotal;
  final bool isWinningOption;

  const OptionResultWidget(
      {Key? key,
      required this.optionName,
      required this.votesCount,
      required this.votesTotal,
      required this.isWinningOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 8.0, bottom: 2.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: 36.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: FractionallySizedBox(
                    widthFactor: votesCount / votesTotal,
                    alignment: Alignment.topLeft,
                    child: Container(
                        decoration: BoxDecoration(
                      color: isWinningOption
                          ? const Color(0xFFEFB355)
                          : Colors.grey.shade300,
                    ))),
              ),
            ),
            Container(
              width: 40.0,
              margin: const EdgeInsets.only(left: 12.0),
              child: Text(
                votesCount.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
      Positioned(
          top: 16.0,
          left: 12.0,
          child: Text(
            optionName,
            style: TextStyle(
                fontSize: 16.0,
                color: isWinningOption ? Colors.white : Colors.black,
                fontWeight: isWinningOption ? FontWeight.bold : FontWeight.normal),
          ))
    ]);
  }
}
