import 'package:flutter/material.dart';

class AddProposalAnswer extends StatelessWidget {
  const AddProposalAnswer({Key? key, required this.add}) : super(key: key);

  final VoidCallback add;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, color: Colors.blue, size: 30),
                    Text(
                      'Añadir opción',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onPressed: () => add,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ));
  }
}
