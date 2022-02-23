import 'package:demos_app/modules/spaces/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';

bool areSpacesEmpty(SpacesState state) =>
    state.spaces.isEmpty && state.invitations.isEmpty;

bool areOnlySpaces(List<SpaceView> spaces, invitations) =>
    spaces.isNotEmpty && invitations.length == 0;

bool areOnlySpaceInvitations(List<SpaceView> spaces, invitations) =>
    spaces.isEmpty && invitations.length > 0;

bool requiresTabBar(List<SpaceView> spaces, invitations) =>
    spaces.isNotEmpty && invitations.length > 0;
