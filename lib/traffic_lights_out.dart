library traffic_lights_out;

import 'package:one_hour_game_jam/one_hour_game_jam.dart';

/// A cell that keeps track of whether it is lit or not. 
class LightCell extends Cell {
  bool lit;
  String color;
  
  // TODO(amouravski): Maybe add a named constructor this.lit(...)
  LightCell(x, y, this.lit, this.color)
      : super(x, y);
  
  /// Flips lit value. Returns previous value.
  bool flip() {
    lit = !lit;
    return !lit;
  }
  
  String toString() {
    return '($x, $y) ${lit ? "+" : "-"}';
  }
}

/// A block of cells.
class CellBlock {
  List<Cell> _model;
  String color;
  
  CellBlock(this._model, this.color);
}