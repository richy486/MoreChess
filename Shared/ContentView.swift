//
//  ContentView.swift
//  Shared
//
//  Created by Richard Adem on 10/10/23.
//

import SwiftUI

struct ContentView: View {
  @State private var dragOffset = CGSize.zero
  @State private var selectedGridPosition: GridPosition? = nil
  
//  private let board: [[String?]] = [
//    ["🐴", "✈️", "👑"],
//    [nil, nil, nil],
//    ["😡", "💂", "🌭"]
//  ]
  
  @StateObject var boardViewModel = BoardViewModel()
  
  // This data structure is (row, column), most of the other code is (column, row) because that is (x, y).
  @State private var board: [[Piece?]] 
  @State private var showingSheet = false
  
//  = [
//    [PieceGenerator.randomPiece(movingDown: true, horizontalSize: 5, verticalSize: 5), Pieces.🐴(true), PieceGenerator.randomPiece(movingDown: true, horizontalSize: 5, verticalSize: 5), Pieces.👉(true), Pieces.🏰(true)],
//    [nil, nil, nil, nil, nil],
//    [nil, nil, nil, nil, nil],
//    [nil, nil, nil, nil, nil],
//    [Pieces.🐴(false), Pieces.🥷(false), Pieces.🤴(false), Pieces.👸(false), PieceGenerator.randomPiece(movingDown: false, horizontalSize: 5, verticalSize: 5)],
//  ]
  
  private enum Constants {
    static let elementDiameter: CGFloat = 50
    static let movingDownColor = Color(hue: 0.15, saturation: 0.75, brightness: 1)
    static let movingUpColor = Color(hue: 0.55, saturation: 0.75, brightness: 1)
  }
  
  private var rowCount: Int { return board.count }
  private var columnCount: Int {
    return board.reduce(999, { partialResult, row in
      return min(partialResult, row.count)
    })
  }
  
  private var pieceList: [Piece]
//  private var pieceList: [Piece] = {
//    let allBoard = board.joined().compactMap { $0 }
////    let filteredBooks = allBooks.filter({authors.contains($0.author)})
////    let uniquePieces = allBoard.filter(T##isIncluded: (Piece) throws -> Bool##(Piece) throws -> Bool)
//    
//    var uniquePieces: [String: Piece] = [:]
//    for piece in allBoard {
//      uniquePieces[piece.icon] = piece
//    }
//    return Array(uniquePieces.values)
//  }()
  
  init() {
    let initialBoard: [[Piece?]] = [
      [PieceGenerator.randomPiece(movingDown: true, horizontalSize: 5, verticalSize: 5), Pieces.🐴(true), PieceGenerator.randomPiece(movingDown: true, horizontalSize: 5, verticalSize: 5), Pieces.👉(true), Pieces.🏰(true)],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [Pieces.🐴(false), Pieces.🥷(false), Pieces.🤴(false), Pieces.👸(false), PieceGenerator.randomPiece(movingDown: false, horizontalSize: 5, verticalSize: 5)],
    ]
    
    let allBoard = initialBoard.joined().compactMap { $0 }
    var uniquePieces: [String: Piece] = [:]
    for piece in allBoard {
      uniquePieces[piece.icon] = piece
    }
    
    
    
    pieceList = Array(uniquePieces.values)
    board = initialBoard
    
//    for uniquePiece in pieceList {
//      print(uniquePiece.icon)
//      print(uniquePiece.drawMoves())
////      for move in uniquePiece.validMoves {
////        print(move.draw())
////        print("---------------------")
////      }
//    }
//    print(Pieces.🐴(false).validMoves.first!.draw())
//    print("---------------------")
  }
  
  var body: some View {
    VStack {
      let gridOffset = gridOffsetFrom(offset: dragOffset)
      let targetGrid = targetGridFrom(dragIndex: selectedGridPosition, gridOffset: gridOffset)
      
      Spacer()
      Grid(horizontalSpacing: 0, verticalSpacing: 0) {
        ForEach(Array(board.enumerated()), id: \.offset) { rowIndex, row in
          GridRow {
            ForEach(Array(row.enumerated()), id:\.offset) { columnIndex, item in
              let isTarget = targetGrid?.column == columnIndex && targetGrid?.row == rowIndex
              Group {
                if let item {
                  let offset = elementOffset(dragIndex: selectedGridPosition, rowIndex: rowIndex, columnIndex: columnIndex)
                  Text(item.icon)
                    .font(.system(size: 999))
                    .minimumScaleFactor(0.01)                    
                    .frame(width: Constants.elementDiameter, height: Constants.elementDiameter)
                    .background(backgroundColor(isTarget: isTarget, movingDown: item.movingDown))
                    .offset(x: offset.width, y: offset.height)
                    .gesture(
                      DragGesture()
                        .onChanged { gesture in
                          dragOffset = gesture.translation
                          if selectedGridPosition == nil {
                            selectedGridPosition = GridPosition(column: columnIndex, row: rowIndex)
                          }
                        }
                        .onEnded { _ in
                          dragOffset = .zero
                          guard let selectedGridPosition else {
                            fatalError("Selected and target grid position must not be nil when drag ending")
                          }
                          if let targetGrid {
                            // Target grid is only required for a valid move.
                            movePiece(from: selectedGridPosition, to: targetGrid)
                          }
                          self.selectedGridPosition = nil
                        }
                    )
                } else {
                  Color.clear
                    .frame(width: Constants.elementDiameter, height: Constants.elementDiameter)
                }
              } // Group
              .background(
                Rectangle()
                  .stroke(isTarget ? .red : .green,
                          lineWidth: 1)
              )
              .zIndex(isTarget ? 0 : -1) // TODO: this puts the dragged icon behind other icons sometimes
            }
          }
        }
      } // Grid
      
      Spacer()
      Button("Moves") {
        showingSheet.toggle()
      }
      Text("offset: \(dragOffset.width) \(dragOffset.height)")
      Text("grid offset: \(gridOffset.column) \(gridOffset.row)")
      
      
      if let selectedGridPosition, let piece = board[selectedGridPosition.row][selectedGridPosition.column] {
        Text("selected: col: \(selectedGridPosition.column) row: \(selectedGridPosition.row) \(piece.icon)")
      } else {
        Text("selected:")
      }
      
      if let targetGrid {
        Text("target: \(targetGrid.column) \(targetGrid.row)")
      } else {
        Text("target:")
      }
      
      Text("Row count: \(rowCount), Column count: \(columnCount)")
    } // VStack
    .sheet(isPresented: $showingSheet) {
      MoviesView(pieceList: pieceList)
    }
  } // body
  
  
  func elementOffset(dragIndex: GridPosition?, rowIndex: Int, columnIndex: Int) -> CGSize {
    
    if let dragIndex, columnIndex == dragIndex.column && rowIndex == dragIndex.row  {
      return dragOffset
    } else {
      return .zero
    }
  }
  
  func gridOffsetFrom(offset: CGSize) -> GridPosition {
    let x = Int(floor((offset.width + Constants.elementDiameter/2) / Constants.elementDiameter))
    let y = Int(floor((offset.height + Constants.elementDiameter/2) / Constants.elementDiameter))
//    return (x, y)
    return GridPosition(column: x, row: y)
  }
  
  func targetGridFrom(dragIndex: GridPosition?, gridOffset: GridPosition) -> GridPosition? {
    guard let dragIndex, let piece = board[dragIndex.row][dragIndex.column] else {
      return nil
    }
    
    let targetPosition = GridPosition(column: dragIndex.column + gridOffset.column, row: dragIndex.row + gridOffset.row)
    
    // Inside board
    guard targetPosition.column >= 0 && targetPosition.column < columnCount &&
            targetPosition.row >= 0 && targetPosition.row < rowCount else {
      return nil
    }
    
    // Validate position
    for validMove in piece.validMoves {
      // Check for not `moveDown`.
      let validMoveRow = piece.movingDown ? validMove.row : validMove.row * -1
      let validMoveColumn = piece.movingDown ? validMove.column : validMove.column * -1
      
      // If there are two `Int.max` their absolute values must be equal.
      if abs(validMoveRow) == Int.max && abs(validMoveColumn) == Int.max
          && abs(gridOffset.row) != abs(gridOffset.column) {
        continue
      }
      
      if (gridOffset.column == validMoveColumn || (gridOffset.column > 0 && validMoveColumn == Int.max) || (gridOffset.column < 0 && validMoveColumn == -Int.max))
          && (gridOffset.row == validMoveRow || (gridOffset.row > 0 && validMoveRow == Int.max) || (gridOffset.row < 0 && validMoveRow == -Int.max) ) {
        return targetPosition
      }
    }
    
    
    return nil
  }
  
  func movePiece(from: GridPosition, to: GridPosition) {
    let piece = board[from.row][from.column]
    board[to.row][to.column] = piece
    board[from.row][from.column] = nil
  }
  
  func backgroundColor(isTarget: Bool, movingDown: Bool) -> Color {
    if isTarget {
      return Color.red
    } else if movingDown {
      return Constants.movingDownColor
    } else {
      return Constants.movingUpColor
    }
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
