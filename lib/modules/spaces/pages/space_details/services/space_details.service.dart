import 'package:demos_app/core/api/space.api.dart';
import 'package:demos_app/core/models/space.model.dart';
import 'package:demos_app/core/repositories/spaces.repository.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space.bloc.dart';
import 'package:demos_app/modules/spaces/pages/space_details/bloc/space_bloc.events.dart';

class SpaceDetailsService {

  Future<void> updateName(String spaceId, String name) async {
    Space space = await SpaceApi().updateSpaceName(spaceId, name);

    await SpacesRepository().updateSpace(space);

    SpaceBloc().add(UpdateSpaceEvent(spaceId));
  }

  Future<void> updateDescription(String spaceId, String description) async {
    Space space = await SpaceApi().updateSpaceDescription(spaceId, description );

    await SpacesRepository().updateSpace(space);

    SpaceBloc().add(UpdateSpaceEvent(spaceId));
  }

  Future<void> updatePercentages(String spaceId, int participationPercentage, int approvalPercentage) async {
    Space space = await SpaceApi().updateSpacePercentages(spaceId, participationPercentage, approvalPercentage);

    await SpacesRepository().updateSpace(space);

    SpaceBloc().add(UpdateSpaceEvent(spaceId));
  }

}
