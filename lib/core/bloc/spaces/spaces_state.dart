part of 'spaces_bloc.dart';

class SpacesState extends Equatable {
  final List<Space> spaces;
  final List<Space> invitations;
  const SpacesState({required this.spaces, required this.invitations});

  SpacesState copyWith({List<Space>? spaces, List<Space>? invitations}) =>
      SpacesState(
          spaces: spaces ?? this.spaces,
          invitations: invitations ?? this.invitations);

  @override
  List<Object> get props => [this.spaces, this.invitations];
}
