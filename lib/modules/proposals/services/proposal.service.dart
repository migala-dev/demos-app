import 'package:demos_app/core/api/proposal.api.dart';
import 'package:demos_app/core/models/responses/proposal_response.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto.repository.dart';
import 'package:demos_app/core/repositories/manifesto/manifesto_option.repository.dart';
import 'package:demos_app/core/repositories/manifesto/proposal/proposal.repository.dart';
import 'package:demos_app/modules/proposals/pages/proposal_form/models/proposal_form_view.model.dart';

class ProposalService {
  Future<void> createNewProposalDraft(
      String spaceId, ProposalFormView proposalFormView) async {
    final response =
        await ProposalApi().createProposalDraft(spaceId, proposalFormView);
    await _saveProposalResponseOnRepository(response);
  }

  Future<void> updateProposalDraft(String spaceId, String proposalId,
      ProposalFormView proposalFormView) async {
    final response = await ProposalApi()
        .updateProposalDraft(spaceId, proposalId, proposalFormView);
    await _saveProposalResponseOnRepository(response);
  }

  Future<void> publishProposalDraft(String spaceId, String proposalId,
      ProposalFormView proposalFormView) async {
    final response = await ProposalApi()
        .publishProposalDraft(spaceId, proposalId, proposalFormView);
    await _saveProposalResponseOnRepository(response);
  }

  Future<void> createAndPublishProposal(
      String spaceId, ProposalFormView proposalFormView) async {
    final response =
        await ProposalApi().createAndPublishProposal(spaceId, proposalFormView);
    await _saveProposalResponseOnRepository(response);
  }

  Future<void> getProposal(String spaceId, String proposalId) async {
    ProposalResponse response =
        await ProposalApi().getProposal(spaceId, proposalId);

    await _saveProposalResponseOnRepository(response);
  }

  Future<void> cancelProposal(String spaceId, String proposalId) async {
    final response = await ProposalApi().cancelProposal(spaceId, proposalId);

    await _saveProposalResponseOnRepository(response);
  }

  Future<void> _saveProposalResponseOnRepository(
      ProposalResponse response) async {
    if (response.manifesto != null) {
      await ManifestoRepository().insertOrUpdate(response.manifesto!);
    }
    if (response.manifestoOptions != null) {
      for (final manifestoOption in response.manifestoOptions!) {
        await ManifestoOptionRepository().insertOrUpdate(manifestoOption);
      }
    }
    if (response.proposal != null) {
      await ProposalRepository().insertOrUpdate(response.proposal!);
    }
  }
}
