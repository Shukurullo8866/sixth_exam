import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../cubit/api_single_state_cubit/single_state_cubit.dart';

class SingleCubitPage extends StatefulWidget {
  const SingleCubitPage({Key? key}) : super(key: key);

  @override
  State<SingleCubitPage> createState() => _SingleCubitPageState();
}

class _SingleCubitPageState extends State<SingleCubitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Single Cubit"),
        actions: [
          InkWell(
            onTap: () {
              context.read<SingleStateCubit>().getData();
            },
            child: Icon(Icons.send_and_archive),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<SingleStateCubit, CubitSingleState>(
            builder: (context, state) {
          if (state.status == Status.ERROR) {
            return Text(state.error.toString());
          }
          if (state.status == Status.SUCCESS) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5 / 2.8,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: state.codes!.length,
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
                      InkWell(
                        onTap: () async {
                          var url = state.codes![index].url;
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 143,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    state.codes![index].url.toString()),
                                fit: BoxFit.fill,
                                scale: 6),
                          ),
                          child: Column(
                            children: [
                              Text("Duration: ${state.codes![index].duration.toString()}"),
                              //Text("End time: ${state.codes![index].start_time.toString()}"),
                              // Text("Star time: ${state.codes![index].end_time.toString()}"),

                            ],
                          )
                        ),
                      ),
                      // const SizedBox(height: 3),
                      Text(
                        state.codes![index].name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          if (state.status == Status.LOADING) {
            return CircularProgressIndicator();
          }
          return Container();
        }),
      ),
    );
  }
}
