class LarguraLayoutBuilder {
  final telaSmartphone = 600;
  final telaTablet = 768;
  final telaPc = 1023;
  final larguraModal = 450;

  largura(larguraBuilder) {
    var largura = larguraBuilder;

    if (largura < telaSmartphone) {
      largura = largura * 1;
    } else if (largura < telaTablet) {
      largura = largura * 0.6;
    } else if (largura < telaPc) {
      largura = largura * 0.4;
    } else {
      largura = largura * 0.3;
    }
    return largura;
  }
}
