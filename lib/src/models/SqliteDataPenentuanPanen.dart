class SqliteDataPenentuanPanen {
  int _pond_id;
  int _fish_type_id;
  String _sow_date;
  int _seed_amount;
  double _seed_weight;
  int _seed_price;
  int _survival_rate;
  int _feed_conversion_ratio;
  int _feed_id;
  int _target_fish_count;
  int _target_price;
  int _status;

  SqliteDataPenentuanPanen(
      this._pond_id,
      this._fish_type_id,
      this._sow_date,
      this._seed_amount,
      this._seed_weight,
      this._seed_price,
      this._survival_rate,
      this._feed_conversion_ratio,
      this._feed_id,
      this._target_fish_count,
      this._target_price,
      this._status);

// konstruktor versi 2: konversi dari Map ke Contact
  SqliteDataPenentuanPanen.fromMap(Map<String, dynamic> map) {
    this._pond_id = map['pond_id'];
    this._fish_type_id = map['fish_type_id'];
    this._sow_date = map['sow_date'];
    this._seed_amount = map['seed_amount'];
    this._seed_weight = map['seed_weight'];
    this._seed_price = map['seed_price'];
    this._survival_rate = map['survival_rate'];
    this._feed_conversion_ratio = map['feed_conversion_ratio'];
    this._feed_id = map['feed_id'];
    this._target_fish_count = map['target_fish_count'];
    this._target_price = map['target_price'];
    this._status = map['status'];
  }

  int get pond_id => _pond_id;

  set pond_id(int value) {
    _pond_id = value;
  } //getter dan setter (mengambil dan mengisi data kedalam object)
  // getter

  // konversi dari Contact ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['pond_id'] = this._pond_id;
    map['sow_date'] = this._sow_date;
    map['fish_type_id'] = this._fish_type_id;
    map['seed_amount'] = this._seed_amount;
    map['seed_weight'] = this._seed_weight;
    map['seed_price'] = this._seed_price;
    map['survival_rate'] = this._survival_rate;
    map['feed_conversion_ratio'] = this._feed_conversion_ratio;
    map['feed_id'] = this._feed_id;
    map['target_fish_count'] = this._target_fish_count;
    map['target_price'] = this._target_price;
    return map;
  }

  String get sow_date => _sow_date;

  int get status => _status;

  set status(int value) {
    _status = value;
  }

  int get target_price => _target_price;

  set target_price(int value) {
    _target_price = value;
  }

  int get target_fish_count => _target_fish_count;

  set target_fish_count(int value) {
    _target_fish_count = value;
  }

  int get feed_id => _feed_id;

  set feed_id(int value) {
    _feed_id = value;
  }

  int get feed_conversion_ratio => _feed_conversion_ratio;

  set feed_conversion_ratio(int value) {
    _feed_conversion_ratio = value;
  }

  int get survival_rate => _survival_rate;

  set survival_rate(int value) {
    _survival_rate = value;
  }

  int get seed_price => _seed_price;

  set seed_price(int value) {
    _seed_price = value;
  }

  double get seed_weight => _seed_weight;

  set seed_weight(double value) {
    _seed_weight = value;
  }

  int get seed_amount => _seed_amount;

  set seed_amount(int value) {
    _seed_amount = value;
  }

  int get fish_type_id => _fish_type_id;

  set fish_type_id(int value) {
    _fish_type_id = value;
  }

  set sow_date(String value) {
    _sow_date = value;
  }
}
