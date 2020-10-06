
class DataBroker {
  JSONObject json;
  
  void loadData() {
    json = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/25544/55.8018973/12.2828286/0/2/&apiKey=WUX3BH-GCVF8U-QAJYMZ-4KHE");
    
    if (json == null) {
      println("Couldn't parse JSON");
    } else {
      println(json);
    }
  }
}
