import 'package:client_app/screens/inside_call/inside_call_bloc.dart';
import 'package:client_app/screens/inside_call/widgets/mentor_camera_view.dart';
import 'package:client_app/screens/inside_call/widgets/my_camera_view.dart';
import 'package:client_app/screens/inside_call/widgets/timer_end_call_view.dart';
import 'package:client_app/screens/inside_call/widgets/toolbar.dart';
import 'package:flutter/material.dart';

class InsideCallScreen extends StatefulWidget {
  const InsideCallScreen({super.key});

  @override
  State<InsideCallScreen> createState() => _InsideCallScreenState();
}

class _InsideCallScreenState extends State<InsideCallScreen> {
  final bloc = InsideCallBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(context,
        arguments: ModalRoute.of(context)!.settings.arguments);
    bloc.joinAppointment(id: bloc.callID, channelName: bloc.channelName);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.engine.leaveChannel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MentorCameraView(
              rtcEngine: bloc.engine,
              remoteUidStatus: bloc.remoteUidStatus,
              channelName: bloc.channelName,
              timesup: () async {
                await bloc.exitAppointment(id: bloc.callID);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
            MyCameraView(rtcEngine: bloc.engine),
            ValueListenableBuilder<int?>(
                valueListenable: bloc.remoteUidStatus,
                builder: (context, snapshot, child) {
                  if (snapshot != null) {
                    return TimerEndCallView(
                      meetingDurationInMin: bloc.meetingDurationInMin,
                      timesup: () async {
                        await bloc.exitAppointment(id: bloc.callID);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
            CallToolBarView(
              engine: bloc.engine,
              callEnd: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
