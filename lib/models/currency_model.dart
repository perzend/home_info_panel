class Currency {
  int _numCode, _nominal;
  String _charCode, _name, _value;

  Currency(
      this._numCode, this._charCode, this._nominal, this._name, this._value);

  get numCode => this._numCode;
  get charCode => this._charCode;
  get nominal => this._nominal;
  get name => this._name;
  get value => this._value;
}
