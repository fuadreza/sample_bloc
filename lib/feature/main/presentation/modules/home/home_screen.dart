
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/response/location_response.dart';
import 'package:sample_bloc/feature/main/domain/entities/location/state/location_state.dart';
import 'package:sample_bloc/feature/main/injection/injection.dart';
import 'package:sample_bloc/feature/main/presentation/modules/home/home_cubit.dart';
import 'package:sample_bloc/feature/main/presentation/widgets/dialog/show_error_dialog.dart';
import 'package:sample_bloc/feature/main/presentation/widgets/items/item_locations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen(title: 'Home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocProvider(
              create: (_) => di<HomeCubit>(),
              child: BlocConsumer<HomeCubit, LocationState>(
                listener: (BuildContext ctx, LocationState state) {
                  if (state is LocationFailed) {
                    showErrorDialog(ctx, state.message);
                  } else { }
                },
                builder: (BuildContext ctx, LocationState state) {
                  if (state is LocationInit) {
                    ctx.read<HomeCubit>().getLocations();
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LocationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LocationSuccess) {
                    return displayListLocations(ctx, state.locations);
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          Text('No locations'),
                          ElevatedButton(
                            onPressed: () {
                              ctx.read<HomeCubit>().getLocations();
                            },
                            child: Text('Refresh'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayListLocations(BuildContext context, List<LocationResponse> locations) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
              const Duration(seconds: 1), () {
                context.read<HomeCubit>().getLocations();
              }
          );
        },
        child: ListView(
          children: List.generate(
            locations.length,
                (index) {
              return ItemLocation(locationResponse: locations[index]);
            },
          ),
        ),
      ),
    );
  }
}
