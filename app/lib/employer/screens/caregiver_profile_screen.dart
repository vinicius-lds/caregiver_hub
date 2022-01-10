import 'package:caregiver_hub/employer/models/caregiver.dart';
import 'package:caregiver_hub/employer/models/service.dart';
import 'package:caregiver_hub/employer/models/skill.dart';
import 'package:caregiver_hub/employer/widgets/caregiver_pricing.dart';
import 'package:caregiver_hub/employer/widgets/caregiver_recomendation_list.dart';
import 'package:caregiver_hub/employer/widgets/contact_item.dart';
import 'package:caregiver_hub/employer/widgets/star_rating.dart';
import 'package:caregiver_hub/shared/widgets/multi_select_chip_field_custom.dart';
import 'package:flutter/material.dart';

class CaregiverProfileScreen extends StatelessWidget {
  const CaregiverProfileScreen({Key? key}) : super(key: key);

  void _pushChat(BuildContext context) {
    print('pushChat');
  }

  void _pushWhatsApp(BuildContext context) {
    print('pushWhatsApp');
  }

  void _pushPhone(BuildContext context) {
    print('pushPhone');
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final caregiver = args['caregiver'] as Caregiver;
    return LayoutBuilder(
      builder: (bContext, constraints) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: constraints.maxHeight * 0.33,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(caregiver.name),
                background: Hero(
                  tag: caregiver.id,
                  child: Image.network(
                    caregiver.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ContactItem(
                            icon: const AssetImage('assets/images/chat.png'),
                            size: constraints.maxHeight * 0.1,
                            onTap: () => _pushChat(context),
                          ),
                          ContactItem(
                            icon:
                                const AssetImage('assets/images/whatsapp.png'),
                            size: constraints.maxHeight * 0.1,
                            onTap: () => _pushWhatsApp(context),
                          ),
                          ContactItem(
                            icon: const AssetImage('assets/images/phone.png'),
                            size: constraints.maxHeight * 0.1,
                            onTap: () => _pushPhone(context),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CaregiverPricing(
                          startPrice: caregiver.startPrice,
                          endPrice: caregiver.endPrice,
                        ),
                      ),
                      Text(
                        caregiver.bio,
                        textAlign: TextAlign.justify,
                      ),
                      if (caregiver.services.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: MultiSelectChipFieldCustom<Service, String>(
                            items: caregiver.services,
                            displayOnly: true,
                            idFn: (serviceType) =>
                                serviceType == null ? '' : serviceType.id,
                            labelFn: (serviceType) => serviceType == null
                                ? ''
                                : serviceType.description,
                            title: 'Serviços',
                          ),
                        ),
                      if (caregiver.skills.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: MultiSelectChipFieldCustom<Skill, String>(
                            items: caregiver.skills,
                            displayOnly: true,
                            idFn: (serviceType) =>
                                serviceType == null ? '' : serviceType.id,
                            labelFn: (serviceType) => serviceType == null
                                ? ''
                                : serviceType.description,
                            title: 'Habilidades',
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: CaregiverRecomendationList(
                          caregiverId: caregiver.id,
                          rating: caregiver.rating,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
