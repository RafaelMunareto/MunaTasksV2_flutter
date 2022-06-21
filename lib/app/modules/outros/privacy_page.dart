import 'package:flutter/material.dart';
import 'package:munatasks2/app/shared/components/app_bar_widget.dart';

class PrivacyPage extends StatefulWidget {
  final String title;
  const PrivacyPage({Key? key, this.title = 'Privacy'}) : super(key: key);
  @override
  PrivacyPageState createState() => PrivacyPageState();
}

class PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: widget.title,
          icon: Icons.privacy_tip,
          context: context,
          settings: true,
          rota: '/home/'),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Política de privacidade para MunaCorp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Na Munatask, acessível em http://munatask.com, uma das nossas principais prioridades é a privacidade dos nossos visitantes. Este documento de Política de Privacidade contém tipos de informações que são coletadas e registradas pela Munatask e como as usamos.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Se você tiver dúvidas adicionais ou precisar de mais informações sobre nossa Política de Privacidade, não hesite em nos contatar.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Esta Política de Privacidade aplica-se apenas às nossas atividades online e é válida para os visitantes do nosso website no que diz respeito às informações que partilharam e/ou recolheram em Munatask. Esta política não se aplica a nenhuma informação coletada offline ou por outros canais que não este site. Nossa Política de Privacidade foi criada com a ajuda do Free Privacy Policy Generator.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 14, 8, 14),
                    child: Text(
                      'Consentimento',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Ao usar nosso site, você concorda com nossa Política de Privacidade e concorda com seus termos.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   As informações pessoais que você deve fornecer e as razões pelas quais você é solicitado a fornecê-las serão esclarecidas para você no momento em que solicitarmos que você forneça suas informações pessoais.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Se você entrar em contato conosco diretamente, poderemos receber informações adicionais sobre você, como seu nome, endereço de e-mail, número de telefone, o conteúdo da mensagem e/ou anexos que você nos enviar e qualquer outra informação que você decida fornecer.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Quando você se registra em uma conta, podemos solicitar suas informações de contato, incluindo itens como nome, nome da empresa, endereço, endereço de e-mail e número de telefone.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Como usamos suas informações.',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Usamos as informações que coletamos de várias maneiras, incluindo:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      ' - Fornecer, operar e manter nosso site \n\n'
                      ' - Melhorar, personalizar e expandir nosso site \n\n'
                      ' - Entenda e analise como você usa nosso site \n\n'
                      ' - Desenvolver novos produtos, serviços, recursos e funcionalidades\n\n'
                      ' - Comunicar-se com você, diretamente ou por meio de um de nossos parceiros, inclusive para atendimento ao cliente, para fornecer atualizações e outras informações relacionadas ao site e para fins de marketing e promocionais\n\n'
                      ' - Enviar-lhe e-mails\n\n'
                      ' - Encontre e evite fraudes\n\n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 14, 8, 14),
                    child: Text(
                      'Arquivos de Registro',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   O Munatask segue um procedimento padrão de uso de arquivos de log. Esses arquivos registram os visitantes quando eles visitam sites. Todas as empresas de hospedagem fazem isso e uma parte da análise dos serviços de hospedagem. As informações coletadas pelos arquivos de log incluem endereços de protocolo da Internet (IP), tipo de navegador, provedor de serviços de Internet (ISP), carimbo de data e hora, páginas de referência/saída e, possivelmente, o número de cliques. Eles não estão vinculados a nenhuma informação que seja pessoalmente identificável. O objetivo das informações é analisar tendências, administrar o site, rastrear o movimento dos usuários no site e coletar informações demográficas.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 14, 8, 14),
                    child: Text(
                      'Políticas de privacidade de parceiros de publicidade',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   O Munatask segue um procedimento padrão de uso de arquivos de log. Esses arquivos registram os visitantes quando eles visitam sites. Todas as empresas de hospedagem fazem isso e uma parte da análise dos serviços de hospedagem. As informações coletadas pelos arquivos de log incluem endereços de protocolo da Internet (IP), tipo de navegador, provedor de serviços de Internet (ISP), carimbo de data e hora, páginas de referência/saída e, possivelmente, o número de cliques. Eles não estão vinculados a nenhuma informação que seja pessoalmente identificável. O objetivo das informações é analisar tendências, administrar o site, rastrear o movimento dos usuários no site e coletar informações demográficas.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 14, 8, 14),
                    child: Text(
                      'Advertising Partners Privacy Policies',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Poderá consultar esta lista para encontrar a Política de Privacidade de cada um dos parceiros publicitários da Munatask.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Poderá consultar esta lista para encontrar a Política de Privacidade de cada um dos parceiros publicitários da Munatask.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   Servidores de anúncios de terceiros ou redes de anúncios usam tecnologias como cookies, JavaScript ou Web Beacons que são usados ​​em seus respectivos anúncios e links que aparecem no Munatask, que são enviados diretamente ao navegador dos usuários. Eles recebem automaticamente seu endereço IP quando isso ocorre. Essas tecnologias são usadas para medir a eficácia de suas campanhas publicitárias e/ou para personalizar o conteúdo publicitário que você vê nos sites que visita. \n\n'
                      '   Observe que a Munatask não tem acesso ou controle sobre esses cookies que são usados ​​por anunciantes de terceiros.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 14, 8, 14),
                    child: Text(
                      'Políticas de privacidade de terceiros',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '   A Política de Privacidade da Munatask não se aplica a outros anunciantes ou sites. Assim, aconselhamos que consulte as respectivas Políticas de Privacidade desses servidores de anúncios de terceiros para obter informações mais detalhadas. Pode incluir suas práticas e instruções sobre como desativar determinadas opções.\n\n'
                      '   Você pode optar por desabilitar os cookies através das opções individuais do seu navegador. Para saber informações mais detalhadas sobre o gerenciamento de cookies com navegadores específicos, pode ser encontrada nos respectivos sites dos navegadores.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 14, 8, 14),
                    child: Text(
                      'Direitos de privacidade da CCPA (não venda minhas informações pessoais)',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      'De acordo com a CCPA, entre outros direitos, os consumidores da Califórnia têm o direito de: \n\n'
                      '  - Solicitar que uma empresa que coleta dados pessoais de um consumidor divulgue as categorias e partes específicas de dados pessoais que uma empresa coletou sobre os consumidores. \n\n'
                      '  - Solicitar que uma empresa exclua quaisquer dados pessoais sobre o consumidor que uma empresa coletou. \n\n'
                      '  - Solicitar que uma empresa que venda os dados pessoais de um consumidor não venda os dados pessoais do consumidor. \n\n'
                      '  - Se você fizer uma solicitação, temos um mês para responder a você. Se você deseja exercer algum desses direitos, entre em contato conosco. \n\n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 14, 8, 14),
                    child: Text(
                      'GDPR Data Protection Rights',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      'Gostaríamos de ter certeza de que você está totalmente ciente de todos os seus direitos de proteção de dados. Todo usuário tem direito ao seguinte: \n\n'
                      '  - O direito de acesso – Você tem o direito de solicitar cópias de seus dados pessoais. Podemos cobrar uma pequena taxa por este serviço. \n\n'
                      '  - O direito de retificação – Você tem o direito de solicitar que corrijamos qualquer informação que você acredite ser imprecisa. Você também tem o direito de solicitar que completemos as informações que você acredita estarem incompletas. \n\n'
                      '  - O direito de apagar – Você tem o direito de solicitar que apaguemos seus dados pessoais, sob certas condições. \n\n'
                      '  - O direito de restringir o processamento – Você tem o direito de solicitar que restrinjamos o processamento de seus dados pessoais, sob certas condições. \n\n'
                      '  - O direito de se opor ao processamento – Você tem o direito de se opor ao nosso processamento de seus dados pessoais, sob certas condições. \n\n'
                      '  - O direito à portabilidade de dados – Você tem o direito de solicitar que transfiramos os dados que coletamos para outra organização, ou diretamente para você, sob certas condições. \n\n'
                      '  - Se você fizer uma solicitação, temos um mês para responder a você. Se você deseja exercer algum desses direitos, entre em contato conosco. \n\n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 14, 8, 14),
                    child: Text(
                      'Informações para crianças',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                    child: Text(
                      '  Outra parte de nossa prioridade é adicionar proteção para crianças enquanto usam a internet. Incentivamos os pais e responsáveis ​​a observar, participar e/ou monitorar e orientar suas atividades online. \n\n'
                      '  A Munatask não coleta intencionalmente nenhuma informação de identificação pessoal de crianças menores de 13 anos. tais informações de nossos registros. \n\n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
