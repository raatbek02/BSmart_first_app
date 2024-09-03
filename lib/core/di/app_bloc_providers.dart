import 'package:bsmart_first_app/core/di/locator_service.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/arrival_bloc/arrival_bloc.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/arrival_detail_bloc/arrival_detail_bloc.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:bsmart_first_app/features/arrival/presentation/cubit/selected_products_cubit.dart';
import 'package:bsmart_first_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;
  final AuthBloc authBloc;

  const AppBlocProviders(
      {super.key, required this.child, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: authBloc),

        BlocProvider<ArrivalBloc>(create: (context) => sl<ArrivalBloc>()),

        BlocProvider<ArrivalDetailBloc>(
            create: (context) => sl<ArrivalDetailBloc>()),

        BlocProvider<ProductBloc>(create: (context) => sl<ProductBloc>()),

// Cubits
        BlocProvider<SelectedProductsCubit>(
            create: (context) => sl<SelectedProductsCubit>()),

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
