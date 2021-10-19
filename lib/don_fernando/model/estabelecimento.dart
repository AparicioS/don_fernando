class Estabelecimento {
  String id;
  String descricao;
  String mensagem;
  String senha;

  Estabelecimento.novo();

  Estabelecimento(this.id,this.descricao, this.mensagem, this.senha);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['descricao'] = descricao;
    map['mensagem'] = mensagem;
    map['senha'] = senha;

    return map;
  }

  Estabelecimento.fromDoc(Map<String, dynamic> map) {
    if (map != null) {
      this.descricao = map['descricao'];
      this.mensagem = map['mensagem'];
      this.senha = map['senha'];
    }
  }
}
