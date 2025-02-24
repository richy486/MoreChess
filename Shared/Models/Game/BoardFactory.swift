/// Initial state for different types of hard coded board, some with random pieces.
enum BoardFactory {
  case fiveByFive
  case chess
  case pawnGame

  func makeBoard(players: [Player]) -> Board2<GamePiece?> {

    var horizontalSize: Int = 0
    var verticalSize: Int = 0

    // Helper piece generator functions.
    func r(_ playerIndex: Int) -> GamePiece {
      PieceGenerator.randomPiece(forPlayer: players[playerIndex],
                                 horizontalSize: horizontalSize,
                                 verticalSize: verticalSize)
    }
    func p(_ playerIndex: Int, _ pieceBases: PieceBase...) -> [GamePiece] {
      pieceBases.map { GamePiece(pieceBase: $0, player: players[playerIndex]) }
    }

    switch self {
      case .fiveByFive:
        horizontalSize = 5
        verticalSize = 5
        return try! Board2<GamePiece?>(nestedArray:  [
          [r(1), r(1), r(1), r(1), r(1)],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          p(0, 🏰, 🐴, 🤴, 👸) + [r(0)],
        ])

      case .chess:
        horizontalSize = 8
        verticalSize = 8
        return try! Board2<GamePiece?>(nestedArray:  [
          p(1, 🏰, 🐴, 🥷, 👸, 🤴, 🥷, 🐴, 🏰),
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          p(0, 🏰, 🐴, 🥷, 👸, 🤴, 🥷, 🐴, 🏰)
        ])
      case .pawnGame:
        horizontalSize = 6
        verticalSize = 6
        return try! Board2<GamePiece?>(nestedArray:  [
          p(1, 🐥, 🐥, 🐥, 🐥, 🐥, 🐥),
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          p(0, 🐥, 🐥, 🐥, 🐥, 🐥, 🐥) ,
        ])
    }
  }
}
