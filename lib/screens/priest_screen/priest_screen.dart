import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/abilities_cubit/abilities_cubit.dart';

class PriestScreen extends StatelessWidget {
  const PriestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BlocProvider.of<AbilitiesCubit>(context).tap(),
      child: AbsorbPointer(
        child: Container(
          child: Center(
            child: Text('księdzu'),
          ),
        ),
      ),
    );
  }
}
