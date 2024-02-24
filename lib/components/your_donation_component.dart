import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:usiiname/components/food_detail_component.dart';
import 'package:usiiname/features/first-order-processing/presentation/bloc/first_order_reservation_bloc.dart';
import 'package:usiiname/features/liveDonations/presentation/bloc/live_donation_bloc.dart';
import 'package:usiiname/features/userDonations/presentation/bloc/user_donations_bloc.dart';

class YourDonationsWrapper extends StatelessWidget {
  const YourDonationsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Donations'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LiveDonationBloc(),
          ),
          BlocProvider(
            create: (context) => UserDonationsBloc(),
          ),
        ],
        child: const YourDonations(),
      ),
    );
  }
}

class YourDonations extends StatefulWidget {
  const YourDonations({super.key});

  @override
  State<YourDonations> createState() => _YourDonationsState();
}

class _YourDonationsState extends State<YourDonations> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<LiveDonationBloc>().add(OnLiveDonation());
      context.read<UserDonationsBloc>().add(OnUserDonation());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
      child: ListView(
        children: [
          Center(
            child: Text(
              'Live Donations.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocListener<LiveDonationBloc, LiveDonationState>(
            listener: (context, state) {
              if (state is LiveDonationError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: BlocBuilder<LiveDonationBloc, LiveDonationState>(
                builder: (context, state) {
              if (state is LiveDonationLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xff5BDDCD)),
                  ),
                );
              }
              if (state is LiveDonationLoaded) {
                return state.liveDonationData.allFoods!.isEmpty
                    ? const Center(
                        child: Text('Currently no Live Food Donation.'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final liveDonationObject =
                              state.liveDonationData.allFoods!;
                          final itemIds = liveDonationObject[index].id;
                          final entireObject = liveDonationObject.firstWhere(
                              (donationItem) => donationItem.id == itemIds);

                          DateTime parsedDate = DateTime.parse(state
                                  .liveDonationData
                                  .allFoods![index]
                                  .createdAt ??
                              '');
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (_) =>
                                            FirstOrderReservationBloc(),
                                        child: FoodDetailComponent(
                                          id: entireObject.id,
                                          dateOfPreparation:
                                              entireObject.dateOfPreparation,
                                          imageUrl: entireObject.imageUrl,
                                          name: entireObject.name,
                                          quantity: entireObject.quantity,
                                          status: entireObject.status,
                                          timeOfDelivery: entireObject
                                              .timeRequiredForDelivery,
                                          timeOfPreparation:
                                              entireObject.timeOfPreparation,
                                          pickUpAddress: entireObject.address,
                                        ),
                                      )));
                            },
                            child: Dismissible(
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {},
                              key: ValueKey(entireObject.id),
                              background: Container(
                                color: Theme.of(context).colorScheme.error,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            child: CachedNetworkImage(
                                                imageUrl:
                                                    '${liveDonationObject[index].imageUrl}',
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation(
                                                                Color(
                                                                    0xff5BDDCD)),
                                                      ),
                                                    ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    const Icon(Icons.error))),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${liveDonationObject[index].name}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              'Quantity: ${liveDonationObject[index].quantity}'),
                                          Text(
                                              'Time of Preparation: ${liveDonationObject[index].timeOfPreparation}'),
                                          Text(
                                              'Date: ${DateFormat.yMEd().format(parsedDate)}'),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: state.liveDonationData.allFoods!.length,
                      );
              }

              return const SizedBox();
            }),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Your Donations.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<UserDonationsBloc, UserDonationsState>(
              builder: (context, state) {
            if (state is UserDonationsLoading) {
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xff5BDDCD)),
              );
            }
            if (state is UserDonationsLoaded) {
              final generalObject = state.userDonationData.newDataStructure;

              return generalObject!.isEmpty
                  ? const Center(
                      child: Text('You currently have no donations !'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DateTime parsedDate = DateTime.parse(
                            generalObject[index].order?.updatedAt ?? '');
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              '${generalObject[index].food!.imageUrl}',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Color(0xff5BDDCD)),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error))
                                              ),

                                  //  ClipRRect(
                                  //   borderRadius: const BorderRadius.all(
                                  //       Radius.circular(50)),
                                  //   child: Image.network(
                                  //     '${generalObject[index].food!.imageUrl}',
                                  //     width: 80,
                                  //     height: 80,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${generalObject[index].food!.name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        'Quantity: ${generalObject[index].food!.quantity}'),
                                    Text(
                                        'Status: ${generalObject[index].order!.status} '),
                                    Text(
                                        'Date: ${DateFormat.yMEd().format(parsedDate)}'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount:
                          state.userDonationData.newDataStructure!.length,
                    );
            }
            return const SizedBox();
          }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
