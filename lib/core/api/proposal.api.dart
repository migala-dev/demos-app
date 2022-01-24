import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/constans/proposals.path.dart';
import 'package:demos_app/core/enums/proposal/proposal_option_type.enum.dart';
import 'package:demos_app/core/models/responses/proposals/send_proposal_draft_response.dart';

class ProposalApi {
  Future<SendProposalDraftResponse> sendProposalDraft(
    String spaceId,
    String title,
    String content,
    ProposalOptionType type,
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
    final response = SendProposalDraftResponse.fromObject(httpResponse);

    return response;
  }
}
