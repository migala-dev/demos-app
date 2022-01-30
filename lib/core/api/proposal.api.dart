import 'package:demos_app/config/themes/cubit/throw_behavior.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/constans/proposals.path.dart';
import 'package:demos_app/core/enums/manifesto_option_type.enum.dart';
import 'package:demos_app/core/models/responses/proposal_response.dart';

class ProposalApi {
  Future<ProposalResponse> createProposalDraft(
    String spaceId,
    String? title,
    String? content,
    ManifestoOptionType type,
    List<Map<String, dynamic>> options,
  ) async {
    final String endpoint = ProposalsPath().getDraftPath(spaceId);
    final Map<String, dynamic> body = {
      'title': title,
      'content': content,
      'optionType': type.index,
      'options': options
    };

    final httpResponse = await Api.post(endpoint, body, null);
    final response = ProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<ProposalResponse> getProposal(String spaceId, String proposalId) async {
    String endpoint = ProposalsPath().getProposalPath(spaceId, proposalId);
    ThrowBehavior throwBehavior = ThrowBehavior(showError: false);

    final httpResponse = await Api.get(endpoint, throwBehavior);
    final response = ProposalResponse.fromObject(httpResponse);

    return response;
  }
}
