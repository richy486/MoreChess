/// Initial state for different types of hard coded board, some with random pieces.
enum BoardFactory {
  case fiveByFive
  case chess

  func makeBoard(players: [Player]) -> Board {

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
        return [
          [r(1), r(1), r(1), r(1), r(1)],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil],
          p(0, 🏰, 🐴, 🤴, 👸) + [r(0)],
        ]

      case .chess:
        horizontalSize = 8
        verticalSize = 8
        return [
          p(1, 🏰, 🐴, 🥷, 👸, 🤴, 🥷, 🐴, 🏰),
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          p(0, 🏰, 🐴, 🥷, 👸, 🤴, 🥷, 🐴, 🏰)
        ]
    }
  }
}
