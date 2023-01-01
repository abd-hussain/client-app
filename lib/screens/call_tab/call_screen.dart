import 'package:client_app/screens/call_tab/call_bloc.dart';
import 'package:client_app/screens/call_tab/widgets/call_view.dart';
import 'package:client_app/screens/call_tab/widgets/no_call_view.dart';
import 'package:client_app/screens/home_tab/widgets/header.dart';
import 'package:client_app/utils/constants/database_constant.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final bloc = CallBloc();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  //TODO handle when the user is not loggedin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderHomePage(),
          FutureBuilder(
              future: bloc.getClientAppointments(),
              builder: (context, snapshot1) {
                if (snapshot1.hasData) {
                  final appointment = bloc.checkIfThereIsAnyMeetingTodayAndReturnTheNearsOne(snapshot1.data!.data);
                  if (appointment != null) {
                    return CallView(
                      timerStartNumberHour: appointment.hour,
                      timerStartNumberMin: appointment.minute,
                      timerStartNumberSec: appointment.second,
                    );
                  } else {
                    return noCallView();
                  }
                } else {
                  return noCallView();
                }
              }),
          //TODO: handle other status
        ],
      ),
    );
  }

  Widget noCallView() {
    return FutureBuilder(
        future: bloc.listOfCategories(),
        builder: (context, snapshot2) {
          return NoCallView(
            language: bloc.box.get(DatabaseFieldConstant.language),
            listOfCategories: snapshot2.data ?? [],
          );
        });
  }
}
