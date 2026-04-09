import 'dart:convert';
String markDown(Map<String, dynamic> dict) {
  String text = '';

  for (String key in dict.keys) {
    var value = dict[key];

    String txt = '';

    if (value is Map) {
      for (var k in value.keys) {
        txt += '- **${edit(k)}** : ${edit(value[k])} \n\n';
      }

      text += '### $key\n ---\n$txt\n';

    }
    else if (value is List) {
      for (var item in value) {
        txt += '- ${edit(item)}\n';
      }

      text += '### $key\n ---\n$txt\n';
    }
    else {
      text += '### $key\n ---\n${edit(value)}\n\n';
    }
  }

  return text;
}


String edit(String x){
  // to do: will work on this after the checklist page
  // List<String>sentence=x.split('');
  // String final_text='';
  // for(int i=0;i<sentence.length;i++){
  //   if(dangerKeywords.contains(sentence[i].toLowerCase())) {
  //     final_text += ' ${sentence[i]}';
  //   }
  //   else {
  //     final_text += sentence[i];
  //   }
  // }
  //
  // return final_text;

  return x;
}




List<String> dangerKeywords = [
  "danger",
  "fatal",
  "toxic",
  "poison",
  "flammable",
  "extremely flammable",
  "explosive",
  "corrosive",
  "carcinogenic",
  "cancer",
  "mutagenic",
  "genetic defects",
  "teratogenic",
  "reproductive toxicity",
  "aspiration hazard",
  "lethal",
  "deadly",
  "harmful",
  "irritant",
  "sensitizer",
  "asphyxiant",
  "oxidizer",
  "reactive",
  "unstable",
  "self-reactive",
  "pyrophoric",
  "peroxide",
  "organic peroxide",
  "compressed gas",
  "cryogenic",
  "radioactive",
  "biohazard",

  // Exposure & health
  "inhalation",
  "ingestion",
  "skin absorption",
  "lung damage",
  "organ damage",
  "respiratory failure",
  "burns",
  "chemical burns",
  "eye damage",
  "blindness",
  "dizziness",
  "drowsiness",
  "unconsciousness",
  "coma",
  "death",

  // Fire & explosion
  "ignition",
  "spark",
  "flash",
  "flashback",
  "vapour",
  "vapors",
  "fumes",
  "combustible",
  "fire",
  "explosion",
  "blast",
  "detonation",
  "burning",
  "smoke",
  "heat",
  "flame",

  // Environmental
  "aquatic toxicity",
  "toxic to aquatic life",
  "long-lasting effects",
  "environmental hazard",
  "water contamination",
  "soil contamination",
  "bioaccumulate",
  "persistent",
  "hazardous waste",
  "pollutant",
  "spill",
  "leak",
  "release",

  // Emergency actions
  "evacuate",
  "emergency",
  "immediate",
  "urgent",
  "medical attention",
  "do not induce vomiting",
  "seek medical advice",
  "breathing apparatus",
  "eliminate ignition sources",
  "isolate area",
];

