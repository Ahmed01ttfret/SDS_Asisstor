
List<Map<String, String>>Chunks(String text){
  List<Map<String, String>> messages = [];
  if(text.length<2000){
    messages.add({
      "role": "user",
      "content": text,
    });
  }else{
    int chunkSize = 2000;
    for (int i = 0; i < text.length; i += chunkSize) {
      messages.add({
        "role": "user",
        "content": '${chunkSize+1} of ${text.length} ${text.substring(i, i + chunkSize > text.length ? text.length : i + chunkSize,)}',
      });
    }


  }

  return messages;
}