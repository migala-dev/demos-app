import 'package:demos_app/core/bloc/spaces/spaces_bloc.dart';
import 'package:demos_app/modules/spaces/models/space_view.model.dart';

bool areSpacesEmpty(SpacesState state) =>
    state.spaces.length == 0 && state.invitations.length == 0;

bool areOnlySpaces(List<SpaceView> spaces, invitations) =>
    spaces.length > 0 && invitations.length == 0;

bool areOnlySpaceInvitations(List<SpaceView> spaces, invitations) =>
    spaces.length == 0 && invitations.length > 0;

bool requiresTabBar(List<SpaceView> spaces, invitations) =>
    spaces.length > 0 && invitations.length > 0;
