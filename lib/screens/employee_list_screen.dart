import 'package:demo_app/bloc/employee_bloc/employee_event.dart';
import 'package:demo_app/widgets/body_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/employee_bloc/employee_bloc.dart';
import '../bloc/employee_bloc/employee_state.dart';
import '../widgets/app_bar_icon.dart';
import '../widgets/button.dart';
import '../widgets/employee_card.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<EmployeeBloc>(context, listen: false)
        .add(const FetchEmployeeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Attend List'),
        titleTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        actions: [
          AppBarIcon(
            onPressedHandler: () {},
            isBadge: false,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BodyContainer(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Button(
                      buttonText: 'Request',
                      isPrimary: false,
                    )),
                    SizedBox(width: 16),
                    Expanded(
                      child: Button(
                        buttonText: 'Approve',
                        isPrimary: true,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.errorMessage != null) {
                      return Center(child: Text(state.errorMessage ?? ''));
                    } else if (state.isLoading == false &&
                        state.errorMessage == null) {
                      return ListView.builder(
                        itemCount: state.fetchedEmployees?.length ?? 0,
                        itemBuilder: (context, index) {
                          final employee = state.fetchedEmployees![index];
                          return EmployeeCard(
                            details: employee,
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
