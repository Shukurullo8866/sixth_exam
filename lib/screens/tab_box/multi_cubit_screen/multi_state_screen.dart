import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/api_multi_state_cubit/multi_state_cubit.dart';

class MultiCubitPage extends StatefulWidget {
  const MultiCubitPage({Key? key}) : super(key: key);

  @override
  State<MultiCubitPage> createState() => _MultiCubitPageState();
}

class _MultiCubitPageState extends State<MultiCubitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Multi Cubit"),
          actions: [
            InkWell(
              onTap: () {
                context.read<MultiStateCubit>().getData();
              },
              child: const Icon(Icons.send_and_archive),
            )
          ],
        ),
        body: Center(
          child: BlocBuilder<MultiStateCubit, MultiStateStateCubit>(
            builder: (context, state) {
              if (state is GettingDataInProgres) {
                return const CircularProgressIndicator();
              }
              if (state is GettingDataInSucces) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5 / 2.8,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: state.cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.only(top: 2),
                      margin: const EdgeInsets.only(
                          top: 6, left: 3, right: 3, bottom: 2),
                      width: 100,
                      height: 150,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            width: double.infinity,
                            height: 143,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      state.cards[index].url.toString()),
                                  fit: BoxFit.fill,
                                  scale: 6),
                            ),
                            child: Column(
                              children: [
                                Text(
                                    "Duration: ${state.cards[index].duration.toString()}"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            state.cards[index].name,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              if (state is GettingDataInFailurys) {
                return const Text("Error");
              }
              return Container();
            },
          ),
        ));
  }
}
