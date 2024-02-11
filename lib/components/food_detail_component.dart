import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usiiname/components/your_donation_component.dart';
import 'package:usiiname/features/first-order-processing/models/first_order_request.dart';
import 'package:usiiname/features/first-order-processing/presentation/bloc/first_order_reservation_bloc.dart';

class FoodDetailComponent extends StatelessWidget {
  final String? name;
  final String? pickUpAddress;
  final String? dateOfPreparation;
  final String? imageUrl;
  final int? quantity;
  final String? status;
  final String? timeOfPreparation;
  final String? timeOfDelivery;
  final int? id;

  const FoodDetailComponent(
      {super.key,
      required this.id,
      required this.dateOfPreparation,
      required this.imageUrl,
      required this.name,
      required this.pickUpAddress,
      required this.quantity,
      required this.status,
      required this.timeOfDelivery,
      required this.timeOfPreparation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: Column(children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: CachedNetworkImage(
                          imageUrl: '$imageUrl',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xff5BDDCD)),
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error))
                      // Image.network(
                      //   '$imageUrl',
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Pickup Place: $pickUpAddress'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Date of Preparation: $dateOfPreparation'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Time of preparation: $timeOfPreparation'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Quantity: $quantity'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Status: $status'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Expected Delivery Time: $timeOfDelivery'),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 130.0, top: 20, bottom: 20),
                    child: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                          onPressed: () {
                            final idData =
                                OrderReservationRequest(foodId: id).toJson();
                            context
                                .read<FirstOrderReservationBloc>()
                                .add(OnOrderReservation(id: idData));
                          },
                          child: const Text('Order now')),
                    ),
                  ),
                  BlocListener<FirstOrderReservationBloc,
                      FirstOrderReservationState>(listener: (context, state) {
                    if (state is FirstOrderReservationLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${state.message.message}')));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const YourDonationsWrapper()));
                    }
                    if (state is FirstOrderReservationError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)));
                    }
                  }, child: BlocBuilder<FirstOrderReservationBloc,
                      FirstOrderReservationState>(builder: (context, state) {
                    if (state is FirstOrderReservationLoading) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xff5BDDCD)),
                      );
                    }
                    return const SizedBox();
                  }))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
