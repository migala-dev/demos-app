import 'package:demos_app/enviroments/enviroment.interface.dart';
import 'package:demos_app/enviroments/get_enviroment.dart';

class ProposalsPath {
  String getProposalsPath() {
    final Enviroment enviroment = getEnviroment();
    return '${enviroment.proposalsServiceUrl}/proposals';
  }

  String getSpaceProposalsPath(String spaceId) =>
      '${getProposalsPath()}/$spaceId';

  String getDraftPath(String spaceId) =>
      '${getSpaceProposalsPath(spaceId)}/draft';

  String getProposalPath(String spaceId, String proposalId) => 
    '${getSpaceProposalsPath(spaceId)}/$proposalId';
}
