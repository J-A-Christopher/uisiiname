import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  final String text;
  final Icon iconToBeUsed;
  final Function onpresssed;
  const ReusableContainer(
      {super.key,
      required this.iconToBeUsed,
      required this.text,
      required this.onpresssed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Icon(
            iconToBeUsed.icon,
            size: 35,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 18,
              ),
        ),
        IconButton(
            onPressed: () {
              onpresssed();
            },
            icon: const Icon(Icons.arrow_forward_ios))
      ],
    );
  }
}
