import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usiiname/components/user_first_route_component.dart';
import 'package:usiiname/features/orderstatus/model/order_status_body.dart';
import 'package:usiiname/features/orderstatus/presentation/bloc/order_status_bloc.dart';

class DonationRequests extends StatefulWidget {
  const DonationRequests({super.key});

  @override
  State<DonationRequests> createState() => _DonationRequestsState();
}

class _DonationRequestsState extends State<DonationRequests> {
  //List<RemoteMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    final messages =
        ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    print('messages: ${messages?.data}');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Donation Request'),
        ),
        body: messages == null || messages.data.isEmpty
            ? const Center(
                child: Text('No donation request here'),
              )
            : BlocProvider(
                create: (_) => OrderStatusBloc(),
                child: ListView(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var orderedId = int.tryParse(messages.data['orderId']);
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(messages.data['imageUrl'])),
                          title: Text('${messages.data['foodName']}'),
                          subtitle:
                              Text('Ordered by: ${messages.data['name']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    final orderDataStatus = OrderStatusBody(
                                            orderId: orderedId,
                                            status: 'approved')
                                        .toJson();
                                    context.read<OrderStatusBloc>().add(
                                        OnOrderStatus(
                                            orderStatus: orderDataStatus));
                                  },
                                  icon: const Icon(Icons.check)),
                              IconButton(
                                  onPressed: () {
                                    final orderDataStatus = OrderStatusBody(
                                            orderId: orderedId,
                                            status: 'rejected')
                                        .toJson();
                                    context.read<OrderStatusBloc>().add(
                                        OnOrderStatus(
                                            orderStatus: orderDataStatus));
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          ),
                        );
                      },
                      itemCount: 1,
                    ),
                    BlocListener<OrderStatusBloc, OrderStatusState>(
                      listener: (context, state) {
                        if (state is OrderStatusLoaded) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UserFirstRoute()));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('${state.orderResponse.message}')));
                        }
                        if (state is OrderStatusError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                      },
                      child: BlocBuilder<OrderStatusBloc, OrderStatusState>(
                          builder: (context, state) {
                        if (state is OrderStatusLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff8FE1D7),
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
                    )
                  ],
                ),
              ));
  }
}
