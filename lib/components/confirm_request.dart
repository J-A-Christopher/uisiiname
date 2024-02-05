import 'package:flutter/material.dart';

class ConfirmRequest extends StatelessWidget {
  const ConfirmRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 15, right: 15),
              child: Center(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/avatar.png'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Youth Red Cross VEC',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Quantity: 15',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text('Location: Eldoret',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                        Text('Need before: 2:30 PM',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          )),
                                  Text(
                                    'We are in need of 15 food packets in Eldoret\nLocation before 2:30 PM.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8FE1D7)),
                    child: const Text('REJECT'),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff8FE1D7)),
                      child: const Text('CONFIRM')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
