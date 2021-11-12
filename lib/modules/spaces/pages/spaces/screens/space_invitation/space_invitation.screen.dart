import 'package:demos_app/config/routes/routes.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/services/member.service.dart';
import 'package:demos_app/shared/models/option.model.dart';
import 'package:demos_app/utils/mixins/loading_state_handler.mixin.dart';
import 'package:demos_app/utils/ui/reload_spaces.util.dart';
import 'package:demos_app/widgets/buttons/big_button_widget.dart';
import 'package:demos_app/widgets/general/select_options.widget.dart';
import 'package:demos_app/widgets/space/space_picture.widget.dart';
import 'package:flutter/material.dart';

class SpaceInvitationScreen extends StatefulWidget {
  SpaceInvitationScreen({Key? key}) : super(key: key);

  @override
  State<SpaceInvitationScreen> createState() => _SpaceInvitationScreenState();
}

class _SpaceInvitationScreenState extends State<SpaceInvitationScreen>
    with LoadingStateHandler {
  Option? optionSelected;
  Space? space;
  SpaceView? spaceView;

  @override
  Widget build(BuildContext context) {
    final SpaceView spaceView =
        ModalRoute.of(context)?.settings.arguments as SpaceView;

    getSpace(spaceView);
    setStateView(spaceView);

    return Scaffold(
        body: Container(
      padding:
          EdgeInsets.only(top: 32.0, bottom: 20.0, left: 24.0, right: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    goBack(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      space?.pictureKey == ''
                          ? SpacePicture(
                              width: 150,
                              pictureKey: space?.pictureKey,
                            )
                          : Container(),
                      Container(
                        width: double.infinity,
                        child: _invitationSpaceName(),
                      ),
                    ],
                  )),
              Expanded(
                flex: 3,
                child: SelectOptionListWidget(
                  options: getOptions(),
                  onChange: (option) {
                    setState(() {
                      optionSelected = option;
                    });
                  },
                ),
              ),
            ],
          )),
          BigButton(
              text: "Continuar",
              isLoading: isLoading,
              disabled: optionSelected == null,
              onPressed: () {
                if (optionSelected != null) {
                  optionSelected!.accept();
                }
              }),
        ],
      ),
    ));
  }

  Future<void> getSpace(SpaceView spaceView) async {
    if (space == null) {
      Space? space = await SpacesRepository().findById(spaceView.spaceId);
      setState(() {
        this.space = space;
      });
    }
  }

  void setStateView(SpaceView spaceView) {
    setState(() {
      this.spaceView = spaceView;
    });
  }

  Widget _invitationSpaceName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Espacio"),
        Text(
          space?.name ?? '',
          style: TextStyle(fontSize: 40),
        )
      ],
    );
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  List<Option> getOptions() {
    return [Option('Aceptar', accept), Option('Rechazar', reject)];
  }

  void accept() {
    wrapLoadingTransaction(() async {
      await MemberService().acceptInvitation(spaceView!.spaceId);

      reloadSpaceList();
      
      Navigator.pushNamedAndRemoveUntil(context, Routes.spaces, (r) => false,
          arguments: this.spaceView);
      Navigator.pushNamed(context, Routes.spacesDetails,
          arguments: this.spaceView);
    });
  }

  void reject() async {
    wrapLoadingTransaction(() async {
      await MemberService().rejectInvitation(spaceView!.spaceId);

      reloadSpaceList();

      goBack(context);
    });
  }
}
