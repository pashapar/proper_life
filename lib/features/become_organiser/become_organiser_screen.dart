import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class BecomeOrganiserScreen extends StatelessWidget {
  const BecomeOrganiserScreen({super.key});

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "ProPer life",
            style: theme.textTheme.titleLarge,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(0xff9257ff),
                  Color(0xff5900ff),
                ])),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
                child: Center(
                  child: Text(
                    S.of(context).becomeAnOrganiser,
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.primaryColor, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).theApplicationIsStillInATestVersionSoThe,
                style: theme.textTheme.bodySmall,
                textWidthBasis: TextWidthBasis.parent,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).thereAre3WaysToBecomeAnOrganiserInThe,
                style: theme.textTheme.bodyLarge,
                textWidthBasis: TextWidthBasis.parent,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).InstagramJustWriteToUsFromYourOfficialAccount,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
                textWidthBasis: TextWidthBasis.parent,
              ),
              Text(
                S.of(context).MessengerWriteToUsFromYourBusinessPhoneNumber,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
                textWidthBasis: TextWidthBasis.parent,
              ),
              Text(
                S.of(context).MailWriteToUsFromYourOfficialMailIndicated,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
                textWidthBasis: TextWidthBasis.parent,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                S.of(context).inTheMessageSpecifyYourUsernameSpecifiedDuringRegistrationAnd,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
                textWidthBasis: TextWidthBasis.parent,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                S.of(context).clickOnTheAppropriateIconBelowToFollowTheLink,
                style: theme.textTheme.bodyMedium,
                textWidthBasis: TextWidthBasis.parent,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 64,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              _onOpen(UrlElement(
                                  'https://www.instagram.com/paasha.pp/'));
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.instagram,
                              color: Color(0xfffa7e1e),
                              size: 35,
                            )),
                        Text(
                          '@proper.life',
                          style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.primaryColor, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.telegram,
                        color: Color(0xff0088cc),
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.viber,
                        color: Color(0xff7360f2),
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Color(0xff25d366),
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mail_outline_outlined,
                        color: Color(0xffc71610),
                        size: 35,
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
