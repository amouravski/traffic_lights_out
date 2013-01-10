import 'package:traffic_lights_out/traffic_lights_out.dart';
import 'package:one_hour_game_jam/one_hour_game_jam.dart';


main() {
  var myGame = ['102',
                '002',
                '112'];
  lightGrid = _createLightGrid(myGame);
}

Grid lightGrid;
bool isWon = false;


/** 
 * Creates a simple light grid given a list of strings encoding the rows.
 * 
 * Each block is number a different number.
 * 
 * For example:
 *     [101, 001, 222]
 * creates a grid like:
 *     1 0 1
 *     0 0 1
 *     2 2 2
 */    
Grid _createLightGrid(List<String> grid) {
  var out = new Grid.empty();
  for (int y = 0; y < grid.length; y++) {
    var row = grid[y];
    var gridRow = [];
    for (int x = 0; x < row.length; x++) {
      if (row[x] == '0') {
        gridRow.add(new LightCell(x, y, false, _colorFromNumber(row[x])));
      } else {
        gridRow.add(new LightCell(x, y, true, _colorFromNumber(row[x])));
      }
    }
    out.addRow(gridRow);
  }
  return out;
}

lightClick(LightCell cell, Grid grid) {
  var neighbors = []..addAll(grid.neighborsAsList(cell));
  var lookedAt = []..add(cell);
  var out = []..add(cell);
  for (LightCell n in neighbors) {
    if (lookedAt.contains(n)) {
      continue;
    }
    
    lookedAt.add(n);

    if (!out.contains(n)) {
      out.add(n);
    }
    
    if (n.color == cell.color) {

      for (LightCell p in grid.neighborsAsList(n)) {
        
        if (!out.contains(p)) {
          out.add(p);
        }
      }
      neighbors.addAll(grid.neighborsAsList(n));
    }
  }
  
  
  for (LightCell n in out) {
    n.flip();
  }
  
  isWon = checkForWin(grid);
}

checkForWin(Grid grid) {
  for (List<LightCell> row in grid) {
    for (LightCell cell in row) {
      if (cell.lit) {
        return false;
      }
    }
  }
  
  return true;
}

String _colorFromNumber(String n) {
  switch (n) {
    case '0':
      return 'black';
      break;
    case '1':
      return 'red';
      break;
    case '2':
      return 'blue';
      break;
    case '3':
      return 'green';
      break;
  }
}