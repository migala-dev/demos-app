import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get_enviroment.dart';

class ProposalsPath {
  String getProposalsPath() {
    final Enviroment enviroment = getEnviroment();
    return '${enviroment.manifestoServiceUrl}/proposals';
  }

  String getSpaceProposalsPath(String spaceId) =>
      '${getProposalsPath()}/$spaceId';

  String getDraftPath(String spaceId) =>
      '${getSpaceProposalsPath(spaceId)}/draft';

  String getProposalDraftPath(String spaceId, String proposalId) =>
      '${getSpaceProposalsPath(spaceId)}/draft/$proposalId';

  String getPublishDraftPath(String spaceId, String proposalId) =>
      '${getProposalDraftPath(spaceId, proposalId)}/publish';

  String getPublishPath(String spaceId) =>
      '${getSpaceProposalsPath(spaceId)}/publish';

  String getProposalPath(String spaceId, String proposalId) =>
      '${getSpaceProposalsPath(spaceId)}/$proposalId';
}
