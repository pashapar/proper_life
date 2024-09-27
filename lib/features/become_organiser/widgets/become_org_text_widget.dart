import 'package:flutter/material.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/theme/theme.dart';

class BecomeOrgText extends StatelessWidget {
  const BecomeOrgText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BecOrgTextWidget(
        text: S.of(context).theApplicationIsStillInATestVersionSoThe,
        textStyle: theme.textTheme.bodySmall,
      ),
      const SizedBox(
        height: 10,
      ),
      BecOrgTextWidget(
          text: S.of(context).thereAre3WaysToBecomeAnOrganiserInThe,
          textStyle: theme.textTheme.bodyLarge),
      const SizedBox(
        height: 10,
      ),
      WayToOrgText(
        wayToOrg: S.of(context).InstagramJustWriteToUsFromYourOfficialAccount,
      ),
      WayToOrgText(
        wayToOrg: S.of(context).MessengerWriteToUsFromYourBusinessPhoneNumber,
      ),
      WayToOrgText(
        wayToOrg: S.of(context).MailWriteToUsFromYourOfficialMailIndicated,
      ),
      const SizedBox(
        height: 10,
      ),
      BecOrgTextWidget(
        text: S
            .of(context)
            .inTheMessageSpecifyYourUsernameSpecifiedDuringRegistrationAnd,
        textStyle: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
      ),
      const SizedBox(
        height: 15,
      ),
      BecOrgTextWidget(
        text: S.of(context).clickOnTheAppropriateIconBelowToFollowTheLink,
        textStyle: theme.textTheme.bodyMedium,
      ),
      const SizedBox(
        height: 5,
      ),
    ]);
  }
}

class WayToOrgText extends StatelessWidget {
  final String wayToOrg;

  const WayToOrgText({
    required this.wayToOrg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      wayToOrg,
      style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
      textWidthBasis: TextWidthBasis.parent,
    );
  }
}

class BecOrgTextWidget extends StatelessWidget {
  final textStyle;
  final text;

  const BecOrgTextWidget({
    required this.text,
    required this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textWidthBasis: TextWidthBasis.parent,
    );
  }
}
