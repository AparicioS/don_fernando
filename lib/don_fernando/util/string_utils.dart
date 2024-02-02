class StrUtil{

  static String removerAcentos(String str) {
    var comAcento = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var semAcento = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz'; 
    for (int i = 0; i < comAcento.length; i++) {      
    str = str.replaceAll(comAcento[i], semAcento[i]);
    }
    return str;
  }
  static List listaUpCase(lista){
    return lista.map((item)=> item.toUpperCase()).toList();
  }
  
  static bool  contem(lista,item){
    for (var element in lista) {
      if(equalsIgnoreCase(element.trim(),item.trim())){
        return true;
      }
    }
    return false;    
  }

  static bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

}