class ImcSQFliteModel {
  int _id = 0;
  double _height = 0.0;
  double _weight = 0.0;

  ImcSQFliteModel(this._id, this._height, this._weight);

  int get id => _id;
  set id(int id) {
    _id = id;
  }

  double get height => _height;
  set height(double height) {
    _height = height;
  }

  double get weight => _weight;
  set weight(double weight) {
    _weight = weight;
  }
}
