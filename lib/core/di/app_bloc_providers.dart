// import 'package:cheber_bloc_clean/common/cubits/select_branch_id_cubit.dart.dart';
// import 'package:cheber_bloc_clean/core/di/locator_service.dart';
// import 'package:cheber_bloc_clean/features/appointments/presentation/bloc/planned_bloc/appointments_bloc.dart';
// import 'package:cheber_bloc_clean/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
// import 'package:cheber_bloc_clean/features/auth/presentation/bloc/otp_bloc/otp_bloc.dart';
// import 'package:cheber_bloc_clean/features/bonus/presentation/bloc/bonus_bloc/bonus_bloc.dart';
// import 'package:cheber_bloc_clean/features/bonus/presentation/bloc/detail_bonus_bloc/detail_bonus_bloc.dart';
// import 'package:cheber_bloc_clean/features/categories/presentation/bloc/categories_bloc.dart';
// import 'package:cheber_bloc_clean/features/home/presentation/bloc/branches_main_bloc/branches_main_bloc.dart';
// import 'package:cheber_bloc_clean/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<CategoriesBloc>(
        //   create: (context) => sl<CategoriesBloc>(),
        // ),
        // BlocProvider<AuthBloc>(
        //   create: (context) => sl<AuthBloc>(),
        // ),
        // BlocProvider<OtpBloc>(
        //   create: (context) => sl<OtpBloc>(),
        // ),
        // BlocProvider<ProfileBloc>(
        //   create: (context) => sl<ProfileBloc>(),
        // ),
        //  BlocProvider<BonusListBloc>(
        //   create: (context) => sl<BonusListBloc>(),
        // ),
        //  BlocProvider<DetailBonusBloc>(
        //   create: (context) => sl<DetailBonusBloc>(),
        // ),
        //  BlocProvider<BranchesMainBloc>(
        //   create: (context) => sl<BranchesMainBloc>(),
        // ),
        //  // Добавляем SelectBranchIdCubit
        // BlocProvider<SelectBranchIdCubit>(
        //   create: (context) => sl<SelectBranchIdCubit>(),
        // ),
        //   BlocProvider<AppointmentsBloc>(
        //   create: (context) => sl<AppointmentsBloc>(),
        // ),
      ],
      child: child,
    );
  }
}
