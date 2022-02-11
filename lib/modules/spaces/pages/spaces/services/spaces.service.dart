import 'package:demos_app/core/bloc/current_user_bloc/current_user_bloc.dart';
import 'package:demos_app/core/models/user.model.dart';
import 'package:demos_app/modules/spaces/models/invitation_view.model.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';
import 'package:demos_app/modules/spaces/repositories/invitation_view.repository.dart';
import 'package:demos_app/modules/spaces/repositories/space_view.repository.dart';

class SpaceService {
  static final SpaceService _spaceService = SpaceService._internal();

  SpaceService._internal();

  factory SpaceService() {
    return _spaceService;
  }

  Future<List<SpaceView>> getSpaces() async {
    User? currentUser = CurrentUserBloc().state;

    if (currentUser != null) {
      List<SpaceView> spaces =
          await SpaceViewsRepository().getSpacesByUserId(currentUser.userId!);
      return spaces;
    }

    return [];
  }

  Future<List<InvitationView>> getInvitations() async {
    User? currentUser = CurrentUserBloc().state;

    if (currentUser != null) {
      List<InvitationView> invitations = await InvitationViewsRepository()
          .getInvitationsByUserId(currentUser.userId!);
      return invitations;
    }

    return [];
  }
}
