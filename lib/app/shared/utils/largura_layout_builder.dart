
class LarguraLayoutBuilder {
  largura(larguraBuilder)
  {
    var largura = larguraBuilder;

    if (largura < 600) {
      largura = largura * 1;
    } else if (largura < 768) {
      largura = largura * 0.6;
    } else if (largura < 1023) {
      largura = largura * 0.4;
    } else {
      largura = largura * 0.3;
    }
    return largura;
  }
}