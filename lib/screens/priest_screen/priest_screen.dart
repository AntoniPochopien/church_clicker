import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cubits/abilities_cubit/abilities_cubit.dart';

class PriestScreen extends StatelessWidget {
  const PriestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BlocProvider.of<AbilitiesCubit>(context).tap(),
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/svg/active/active_bg_1.svg',
            fit: BoxFit.cover,
          ),
          SvgPicture.asset('assets/images/svg/active/active_lvl_1.svg')
        ],
      ),
    );
  }
}
