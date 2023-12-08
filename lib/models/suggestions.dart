class Suggestions {
  double sicaklik;
  String hissiyat = '';

  Suggestions({required this.sicaklik}) {
    if (sicaklik >= 0 && sicaklik <= 10) {
      hissiyat = "Soğuk Hissedilebilir";
    } else {
      hissiyat = "Normal";
    }
  }

  String oneri() {
    if (hissiyat == "Soğuk Hissedilebilir") {
      return "Katmanlar halinde giyinmek önemlidir.\n\nCildinizi soğuktan korumak için kalın giysiler ve uygun aksesuarlar kullanın.\n\nRüzgarın etkisi daha fazla hissedilebilir, bu nedenle rüzgarlı günlerde daha dikkatli olun.";
    } else {
      return "Sıcaklık normal, özel bir öneri yok.";
    }
  }

  String sogukAlgisi() {
    if (hissiyat == "Soğuk Hissedilebilir") {
      return """
        - Sıcak içecekler içmek ve sıcak yemekler tüketmek rahatlamanıza yardımcı olabilir.
        - Dışarı çıkarken başınızı, ellerinizi ve ayaklarınızı sıcak tutmaya özen gösterin.
      """;
    } else {
      return "Sıcaklık normal, özel bir öneri yok.";
    }
  }

  String aktiviteSeviyeleri() {
    if (hissiyat == "Soğuk Hissedilebilir") {
      return "Dışarıda uzun süreli aktiviteler planlıyorsanız, sıcak giyinmek ve vücudunuzu korumak önemlidir.\n\nFiziksel aktivite, vücut sıcaklığını artırabilir, bu nedenle giyim seçimlerinizi buna göre yapın.";
    } else {
      return "Sıcaklık normal, özel bir öneri yok.";
    }
  }

  String havaKosullarinaBagliHissetme() {
    // Özel hava koşulları ile ilgili hissiyat ve önerileri buraya ekleyebilirsiniz.
    return "Hava koşullarına bağlı hissiyat: ...";
  }
}

void main() {
  // Örnek kullanım
  Suggestions suggestions = Suggestions(sicaklik: 5);

  print("Hissiyat: ${suggestions.hissiyat}");
  print("Öneriler:\n${suggestions.oneri()}");
  print("Soğuk Algısı:\n${suggestions.sogukAlgisi()}");
  print("Aktivite Seviyeleri:\n${suggestions.aktiviteSeviyeleri()}");
  print(
      "Hava Koşullarına Bağlı Hissetme:\n${suggestions.havaKosullarinaBagliHissetme()}");
}
