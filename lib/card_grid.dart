import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:bingogamehousie/theme_color.dart';
import 'package:bingogamehousie/card_cell.dart';
import 'package:bingogamehousie/model.dart';
import 'package:bingogamehousie/card_grid_cell.dart';

class CardGrid extends StatefulWidget {
  final int cardNumber;
  final int cardGridUpdateSign;

  const CardGrid({
    super.key,
    required this.cardNumber,
    required this.cardGridUpdateSign,
  });

  @override
  State<CardGrid> createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  static final Random _random = Random();
  late List<List<CardCell>> _grid;
  final Set<int> _highlighted = <int>{};
  late int _cardNumber;
  late ThemeColor _themeColor;
  late String _subject;
  late String _cardState;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() async {
    _themeColor = ThemeColor(context: context);
    _cardNumber = widget.cardNumber;
    _updateSubject();
    await _restoreCardState();
    _loadBallHistory();
    _updateBingoHighlight();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant CardGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    _didUpdateWidget(oldWidget);
  }

  void _didUpdateWidget(covariant CardGrid oldWidget) async {
    if (widget.cardGridUpdateSign == -1) {
    } else if (widget.cardGridUpdateSign == 0) {
      _updateSubject();
      await _restoreCardState();
      _loadBallHistory();
      _updateBingoHighlight();
      if (mounted) {
        setState(() {});
      }
    } else {
      if (oldWidget.cardGridUpdateSign != widget.cardGridUpdateSign) {
        _loadBallHistory();
        _updateBingoHighlight();
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  int _indexOf(int row, int col) => col * 9 + row;

  void _updateSubject() {
    if (_cardNumber == 1) {
      _subject = Model.cardSubject1;
    } else if (_cardNumber == 2) {
      _subject = Model.cardSubject2;
    } else if (_cardNumber == 3) {
      _subject = Model.cardSubject3;
    } else if (_cardNumber == 4) {
      _subject = Model.cardSubject4;
    } else if (_cardNumber == 5) {
      _subject = Model.cardSubject5;
    } else if (_cardNumber == 6) {
      _subject = Model.cardSubject6;
    }
  }

  Future<void> _restoreCardState() async {
    if (_cardNumber == 1) {
      _cardState = Model.cardState1;
    } else if (_cardNumber == 2) {
      _cardState = Model.cardState2;
    } else if (_cardNumber == 3) {
      _cardState = Model.cardState3;
    } else if (_cardNumber == 4) {
      _cardState = Model.cardState4;
    } else if (_cardNumber == 5) {
      _cardState = Model.cardState5;
    } else if (_cardNumber == 6) {
      _cardState = Model.cardState6;
    }
    _grid = List.generate(3,(_) => List.generate(9,(_) => CardCell(number:0)));
    final bool restored = _loadStoredCardState(_cardState);
    if (!restored) {
      _generateNewCard();
      await _saveCardState();
    }
  }
  
  bool _loadStoredCardState(String stored) {
    if (stored.isEmpty) {
      return false;
    }
    final List<int> entries = stored
      .split(',')
      .where((element) => element.isNotEmpty)
      .map((e) => int.tryParse(e))
      .where((e) => e != null)
      .map((e) => e!)
      .toList();
    if (entries.length != 27) {
      return false;
    }
    int index = 0;
    for (int col = 0; col < 9; col++) {
      for (int row = 0; row < 3; row++) {
        _grid[row][col]
          ..number = entries[index]
          ..open = false;
        index++;
      }
    }
    return true;
  }

  void _generateNewCard() {
    List<List<int?>> housieCard = List.generate(3, (_) => List<int?>.filled(9, 0));
    List<List<int>> columnPools = List.generate(9, (colIndex) {
      int start = colIndex * 10 + 1;
      int end = (colIndex == 8) ? 90 : start + 9;
      return List.generate(end - start + 1, (i) => start + i)..shuffle();
    });
    List<int> rowCounts = List.filled(3, 0);
    List<int> colCounts = List.filled(9, 0);
    for (int col = 0; col < 9; col++) {
      int rowToPlace = Random().nextInt(3);
      housieCard[rowToPlace][col] = columnPools[col].removeAt(0);
      rowCounts[rowToPlace]++;
      colCounts[col]++;
    }
    bool changed = true;
    while (changed) {
      changed = false;
      for (int r = 0; r < 3; r++) {
        while (rowCounts[r] < 5) {
          List<int> potentialCols = List.generate(9, (index) => index)..shuffle();
          bool addedToRow = false;
          for (int c in potentialCols) {
            if (housieCard[r][c] == 0 && colCounts[c] < 3) {
              if (columnPools[c].isNotEmpty) {
                housieCard[r][c] = columnPools[c].removeAt(0);
                rowCounts[r]++;
                colCounts[c]++;
                addedToRow = true;
                changed = true;
                break;
              }
            }
          }
          if (!addedToRow) {
            break;
          }
        }
      }
    }
    for (int r = 0; r < 3; r++) {
      while (rowCounts[r] > 5) {
        List<int> colsInRow = [];
        for (int c = 0; c < 9; c++) {
          if (housieCard[r][c] != 0) {
            colsInRow.add(c);
          }
        }
        colsInRow.shuffle();
        bool removedFromRow = false;
        for (int c in colsInRow) {
          if (colCounts[c] > 1) {
            housieCard[r][c] = 0;
            rowCounts[r]--;
            colCounts[c]--;
            removedFromRow = true;
            changed = true;
            break;
          }
        }
        if (!removedFromRow) {
          break;
        }
      }
    }
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 9; col++) {
        _grid[row][col].number = housieCard[row][col]!;
      }
    }
  }

  Future<void> _saveCardState() async {
    final buffer = StringBuffer();
    for (int col = 0; col < 9; col++) {
      for (int row = 0; row < 3; row++) {
        final cellNumber = _grid[row][col].number;
        buffer..write(cellNumber.toString())..write(',');
      }
    }
    await Model.setCardState(_cardNumber, buffer.toString());
  }

  void _loadBallHistory() {
    final String ballHistory = Model.ballHistory;
    if (ballHistory.isEmpty) {
      return;
    }
    final List<int> ballHistoryNumbers = ballHistory
        .split(',')
        .map((e) => int.tryParse(e))
        .where((e) => e != null)
        .map((e) => e!)
        .where((e) => e >= 0 && e < 90)
        .toList();
    if (ballHistoryNumbers.isEmpty) {
      return;
    }
    for (int col = 0; col < 9; col++) {
      for (int row = 0; row < 3; row++) {
        if (ballHistoryNumbers.contains(_grid[row][col].number - 1)) {
          _grid[row][col].open = true;
        }
      }
    }
  }

  void _updateBingoHighlight() {
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _themeColor.mainCardColor,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 5),
        child: Column(children:[
          Text(_subject),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 27,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              childAspectRatio: 1.8,
            ),
            itemBuilder: (context, index) {
              final row = index ~/ 9;
              final col = index % 9;
              return _buildCardCell(row, col);
            },
          )
        ]),
      )
    );
  }

  Widget _buildCardCell(int row, int col) {
    final cell = _grid[row][col];
    final bool isOpen = cell.open;
    final int index = _indexOf(row, col);
    final bool highlighted = _highlighted.contains(index);
    final Color background = isOpen ? _themeColor.cardTableOpenBackColor : _themeColor.cardTableCloseBackColor;
    final Color baseTextColor = isOpen ? _themeColor.cardTableOpenForeColor : _themeColor.cardTableCloseForeColor;
    final Color textColor = highlighted ? _themeColor.cardTableBingoForeColor : baseTextColor;
    final String label = cell.number.toString();
    if (cell.number == 0) {
      return const SizedBox.shrink();
    } else {
      return CardGridCell(
        isOpen: isOpen,
        label: label,
        background: background,
        textColor: textColor,
      );
    }
  }

}
