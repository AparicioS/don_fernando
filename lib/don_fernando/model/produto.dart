class Produto {
  String id;
  String descricao;
  String valor;
  String medida;

  Produto.novo();

  Produto(this.id,this.descricao, this.valor, this.medida);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['descricao'] = descricao;
    map['valor'] = valor;
    map['medida'] = medida;

    return map;
  }

  Produto.fromDoc(Map<String, dynamic> map) {
    if (map != null) {
      this.id = map['id'];
      this.descricao = map['descricao'];
      this.valor = map['valor'];
      this.medida = map['medida'];
    }
  }
}