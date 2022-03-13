import 'package:demos_app/config/themes/cubit/throw_behavior.dart';
import 'package:demos_app/core/api/api.dart';
import 'package:demos_app/constans/proposals.path.dart';
import 'package:demos_app/core/models/responses/proposal_participation_response.model.dart';
import 'package:demos_app/core/models/responses/update_proposal_response.model.dart';
import 'package:demos_app/core/models/responses/proposal_response.dart';
import 'package:demos_app/core/models/responses/vote_proposal_response.model.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';

class ProposalApi {
  Future<ProposalResponse> createProposalDraft(
      String spaceId, ProposalFormView proposalFormView) async {
    final String endpoint = ProposalsPath().getDraftPath(spaceId);
    final Map<String, dynamic> body =
        _getBodyFromProposalFormView(proposalFormView);

    final httpResponse = await Api.post(endpoint, body, null);
    final response = ProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<ProposalResponse> updateProposalDraft(String spaceId,
      String proposalId, ProposalFormView proposalFormView) async {
    final String endpoint =
        ProposalsPath().getProposalDraftPath(spaceId, proposalId);
    final Map<String, dynamic> body =
        _getBodyFromProposalFormView(proposalFormView);

    final httpResponse = await Api.put(endpoint, body, null);
    final response = ProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<ProposalResponse> publishProposalDraft(String spaceId,
      String proposalId, ProposalFormView proposalFormView) async {
    final String endpoint =
        ProposalsPath().getPublishDraftPath(spaceId, proposalId);
    final Map<String, dynamic> body =
        _getBodyFromProposalFormView(proposalFormView);

    final httpResponse = await Api.put(endpoint, body, null);
    final response = ProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<ProposalResponse> createAndPublishProposal(
      String spaceId, ProposalFormView proposalFormView) async {
    final String endpoint = ProposalsPath().getPublishPath(spaceId);
    final Map<String, dynamic> body =
        _getBodyFromProposalFormView(proposalFormView);

    final httpResponse = await Api.post(endpoint, body, null);
    final response = ProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<ProposalResponse> getProposal(String spaceId, String proposalId) async {
    final String endpoint = ProposalsPath().getProposalPath(spaceId, proposalId);
    final ThrowBehavior throwBehavior = ThrowBehavior(showError: false);

    final httpResponse = await Api.get(endpoint, throwBehavior);
    final response = ProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<ProposalParticipationResponse> getProposalParticipation(
      String spaceId, String participationId) async {
    final String endpoint =
        ProposalsPath().getProposalParticipationPath(spaceId, participationId);
    final ThrowBehavior throwBehavior = ThrowBehavior(showError: false);

    final httpResponse = await Api.get(endpoint, throwBehavior);
    final response = ProposalParticipationResponse.fromObject(httpResponse);

    return response;
  }

  Future<UpdateProposalResponse> cancelProposal(
      String spaceId, String proposalId) async {
    final String endpoint =
        ProposalsPath().getCancelProposalPath(spaceId, proposalId);

    final httpResponse = await Api.put(endpoint, null, null);

    final response = UpdateProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<UpdateProposalResponse> deleteProposalDraft(
      String spaceId, String proposalId) async {
    final String endpoint =
        ProposalsPath().getProposalDraftPath(spaceId, proposalId);

    final httpResponse = await Api.delete(endpoint, null);

    final response = UpdateProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<ProposalResponse> updateProposal(String spaceId, String proposalId,
      ProposalFormView proposalFormView) async {
    final String endpoint =
        ProposalsPath().getProposalPath(spaceId, proposalId);
    final Map<String, dynamic> body =
        _getBodyFromProposalFormView(proposalFormView);

    final httpResponse = await Api.put(endpoint, body, null);
    final response = ProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<VoteProposalResponse> voteInFavorProposal(
      String spaceId, String proposalId, String userHash, bool inFavor) async {
    final String endpoint =
        ProposalsPath().getVoteProposalPath(spaceId, proposalId);
    final Map<String, dynamic> body = {
      'userHash': userHash,
      'inFavor': inFavor
    };

    final httpResponse = await Api.put(endpoint, body, null);

    final response = VoteProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<VoteProposalResponse> voteManifestoOptionProposal(String spaceId,
      String proposalId, String userHash, String manifestoOptionId) async {
    final String endpoint =
        ProposalsPath().getVoteProposalPath(spaceId, proposalId);
    final Map<String, dynamic> body = {
      'userHash': userHash,
      'manifestoOptionId': manifestoOptionId
    };

    final httpResponse = await Api.put(endpoint, body, null);

    final response = VoteProposalResponse.fromObject(httpResponse);

    return response;
  }

  Future<VoteProposalResponse> voteNullProposal(String spaceId,
      String proposalId, String userHash, String? nullVoteComment) async {
    final String endpoint =
        ProposalsPath().getVoteProposalPath(spaceId, proposalId);
    final Map<String, dynamic> body = {
      'userHash': userHash,
      'nullVoteComment': nullVoteComment
    };

    final httpResponse = await Api.put(endpoint, body, null);

    final response = VoteProposalResponse.fromObject(httpResponse);

    return response;
  }

  Map<String, dynamic> _getBodyFromProposalFormView(
      ProposalFormView proposalFormView) {
    return {
      'title': proposalFormView.title,
      'content': proposalFormView.content,
      'optionType': proposalFormView.optionType.index,
      'options': proposalFormView.manifestoOptions
          .map((o) =>
              {'title': o.title, 'manifestoOptionId': o.manifestoOptionId})
          .toList()
    };
  }
}
