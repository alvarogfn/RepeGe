import 'package:flutter/material.dart';
import 'package:repege/core/widgets/full_screen_scroll%20copy.dart';
import 'package:repege/core/widgets/paragraph.dart';
import 'package:repege/src/campaigns/data/model/campaign_model.dart';

class CampaignActPage extends StatelessWidget {
  const CampaignActPage(this.campaign, {super.key});

  final CampaignModel campaign;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Acontecimentos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      ),
      body: FullScreenScroll(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ExpansionTile(
                    title: Text('Os macacos atacam'),
                    subtitle: Text('Destruição de todas as bananas'),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Paragraph(
                          '''Era uma vez, um grupo de macacos que viviam em uma floresta tropical. Eles eram felizes e brincalhões, mas também muito curiosos e travessos. Um dia, eles decidiram explorar uma parte da floresta que nunca tinham visto antes. Lá, eles encontraram um lago cheio de patos nadando tranquilamente. Os macacos ficaram fascinados pelos patos e quiseram brincar com eles. Eles começaram a jogar pedras, galhos e frutas na água, tentando acertar os patos. Os patos ficaram assustados e irritados com os macacos, e tentaram se defender bicando-os e esguichando água neles. Mas os macacos não se importaram e continuaram a atacar os patos, achando que era divertido. A briga entre os macacos e os patos durou por muito tempo, até que um dos patos teve uma ideia. Ele chamou os outros patos e disse:
                    * Amigos, esses macacos são muito chatos e malvados. Eles não vão nos deixar em paz. Temos que dar uma lição neles. Vamos fingir que estamos mortos e boiar na água. Assim, eles vão pensar que ganharam e vão embora.
                    Os outros patos concordaram com o plano e fizeram o que o pato disse. Eles pararam de se mexer e ficaram imóveis na superfície do lago. Os macacos viram os patos parados e pensaram que tinham matado todos eles. Eles ficaram felizes e orgulhosos de si mesmos, e começaram a comemorar.
                    * Olhem só, nós somos os mais fortes da floresta! Ninguém pode nos vencer! Vamos pegar esses patos mortos e levar para o nosso chefe. Ele vai ficar impressionado conosco!
                    Os macacos então pularam na água para pegar os patos. Mas assim que eles tocaram nos patos, os patos se mexeram e morderam os macacos com força. Os macacos ficaram surpresos e assustados, e perceberam que tinham caído em uma armadilha. Eles tentaram fugir, mas era tarde demais. Os patos eram mais rápidos e mais fortes na água, e atacaram os macacos sem piedade. Os macacos foram derrotados pelos patos, e tiveram que fugir da floresta, envergonhados e machucados. Eles nunca mais voltaram a perturbar os patos, e aprenderam a respeitar os outros animais da floresta.''',
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '19 de setembro',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
