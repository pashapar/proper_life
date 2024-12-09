import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/theme/theme.dart';

import 'social_media_row_widget.dart';

class BecomeOrgText extends StatelessWidget {
  const BecomeOrgText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: BecOrgTextWidget(
          text: S.of(context).theApplicationIsStillInATestVersionSoThe,
          textStyle: theme.textTheme.bodySmall,
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: BecOrgTextWidget(
            text: S.of(context).thereAre3WaysToBecomeAnOrganiserInThe,
            textStyle: theme.textTheme.bodyLarge),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: theme.cardColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                child: WayToOrgText(
                  wayToOrg: S
                      .of(context)
                      .InstagramJustWriteToUsFromYourOfficialAccount,
                ),
              ),
              Column(
                children: <Widget>[
                  const SocialMediaButton(
                      onPressLink: 'https://www.instagram.com/paashapp/',
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        color: Color(0xfffa7e1e),
                        size: 35,
                      )),
                  Text(
                    '@proper.life',
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: theme.primaryColor, fontSize: 10),
                  )
                ],
              )
            ],
          )),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: theme.cardColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              WayToOrgText(
                wayToOrg:
                    S.of(context).MessengerWriteToUsFromYourBusinessPhoneNumber,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialMediaButton(
                    icon: FaIcon(
                      FontAwesomeIcons.telegram,
                      color: Color(0xff0088cc),
                      size: 35,
                    ),
                  ),
                  SocialMediaButton(
                      icon: FaIcon(
                    FontAwesomeIcons.viber,
                    color: Color(0xff7360f2),
                    size: 35,
                  )),
                  SocialMediaButton(
                      icon: FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Color(0xff25d366),
                    size: 35,
                  )),
                ],
              )
            ],
          )),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: theme.cardColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                child: WayToOrgText(
                  wayToOrg:
                      S.of(context).MailWriteToUsFromYourOfficialMailIndicated,
                ),
              ),
              const SocialMediaButton(
                  icon: Icon(
                Icons.mail_outline_outlined,
                color: Color(0xffc71610),
                size: 35,
              ))
            ],
          )),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: BecOrgTextWidget(
          text: S.of(context).clickOnTheAppropriateIconBelowToFollowTheLink,
          textStyle: theme.textTheme.bodyMedium,
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: BecOrgTextWidget(
          text: S
              .of(context)
              .inTheMessageSpecifyYourUsernameSpecifiedDuringRegistrationAnd,
          textStyle: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
        ),
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
