class BuildHeaders{
  Map<String,String> headers = {};
  BuildHeaders();

  BuildHeaders makeJson(){
    headers.addAll({
      'Content-Type': 'application/json; charset=utf-8'
    });
    return this;
  }

  Map<String,String> finish(){
    return headers;
  }
}