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
  
  @State var gameViewModel = GameViewModel()
  
  @State private var showingSheet = false
  
  private enum Constants {
    static let elementDiameter: CGFloat = 50
    static let movingDownColor = Color(hue: 0.15, saturation: 0.75, brightness: 1)
    static let movingUpColor = Color(hue: 0.55, saturation: 0.75, brightness: 1)
  }
    
  private var pieceList: [Piece]
  
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
    gameViewModel.board = initialBoard
  }
  
  var body: some View {
    VStack {
      let gridOffset = gridOffsetFrom(offset: dragOffset)
      let targetGrid = gameViewModel.targetGridFrom(dragIndex: selectedGridPosition, gridOffset: gridOffset)
      
      Spacer()
      Grid(horizontalSpacing: 0, verticalSpacing: 0) {
        ForEach(Array(gameViewModel.board.enumerated()), id: \.offset) { rowIndex, row in
          GridRow {
            ForEach(Array(row.enumerated()), id:\.offset) { columnIndex, item in
              let isTarget = targetGrid?.column == columnIndex && targetGrid?.row == rowIndex
              Group {
                if let item {
                  let offset = elementOffset(dragIndex: selectedGridPosition, rowIndex: rowIndex, columnIndex: columnIndex)
                  PieceView(piece: item)
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
      
      
      if let selectedGridPosition, let piece = gameViewModel.board[selectedGridPosition.row][selectedGridPosition.column] {
        Text("selected: col: \(selectedGridPosition.column) row: \(selectedGridPosition.row) \(piece.icon)")
      } else {
        Text("selected:")
      }
      
      if let targetGrid {
        Text("target: \(targetGrid.column) \(targetGrid.row)")
      } else {
        Text("target:")
      }
      
      Text("Row count: \(gameViewModel.rowCount), Column count: \(gameViewModel.columnCount)")
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
    return GridPosition(column: x, row: y)
  }
  
  func movePiece(from: GridPosition, to: GridPosition) {
    let piece = gameViewModel.board[from.row][from.column]
    gameViewModel.board[to.row][to.column] = piece
    gameViewModel.board[from.row][from.column] = nil
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
