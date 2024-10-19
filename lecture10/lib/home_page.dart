import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => ColorCubit(),
        child: Center(
          child: BlocBuilder<ColorCubit, Color>(
            builder: (context, state) {
              return Container(
                width: 200,
                height: 200,
                color: state,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.toString()),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ColorCubit>().changeColor();
                      },
                      child: const Text('Change color'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
