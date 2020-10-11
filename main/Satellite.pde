
class Satellite {
  String id; 
  JSONObject json;
  JSONArray data;
  String name;

  float x, y, z, h;
  PVector pos, rv;
  float angleBetween;

  PVector unit_vec = new PVector(1, 0, 0);
  PVector travel;


  Satellite (String id) {
    this.id = id;
  }

  void update() {
    json = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/" + id + "/55.8018973/12.2828286/0/2/&apiKey=WUX3BH-GCVF8U-QAJYMZ-4KHE");

    // Handle errors
    if (json == null) {
      println("Couldn't parse JSON at id=" + id);
    } else if (id == null) {
      println("id must be chosen");
    } else {
      // Success
      //println(json);
    }

    // Get name
    name = json.getJSONObject("info").getString("satname");

    // Load position data
    data = json.getJSONArray("positions");

    JSONObject sat = data.getJSONObject(0);
    float lat = sat.getFloat("satlatitude");
    float lon = sat.getFloat("satlongitude");
    float alt = sat.getFloat("sataltitude");

    float theta = radians(alt) + PI/2;
    float phi = radians(lon) + PI;

    x = earth_r * sin(theta) * cos(phi);
    y = earth_r * cos(theta);
    z = earth_r * sin(theta) * sin(phi);

    h = alt * earth_r/earth_r_real;

    pos = new PVector(x, y, z);
    angleBetween = PVector.angleBetween(unit_vec, pos);
    rv = unit_vec.cross(pos);
  }


  void display() {
    pushMatrix();
    translate(x, y, z);
    rotate(angleBetween, rv.x, rv.y, rv.z);
    translate(h, 0, 0);
    fill(255, 0, 0);
    sphere(2);
    rotate(-angleBetween, rv.x, rv.y, rv.z);
    text(name, unit_vec.x, unit_vec.y, unit_vec.z);
    popMatrix();
  }
}
