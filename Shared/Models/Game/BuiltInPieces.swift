//
//  BuiltInPiece.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

let 🐴 = PieceBase(icon: "🐴", validMoves: [
  // down
  GridCoordinate(column: 1, row: 2),
  GridCoordinate(column: -1, row: 2),
  // left
  GridCoordinate(column: -2, row: 1),
  GridCoordinate(column: -2, row: -1),

  // right
  GridCoordinate(column: 2, row: 1),
  GridCoordinate(column: 2, row: -1),

  // up
  GridCoordinate(column: 1, row: -2),
  GridCoordinate(column: -1, row: -2)
])
// King
let 🤴 = PieceBase(icon: "🤴", validMoves: [
  GridCoordinate(column: 0, row: 1),
  GridCoordinate(column: 0, row: -1),
  GridCoordinate(column: 1, row: 0),
  GridCoordinate(column: -1, row: 0),

  GridCoordinate(column: 1, row: 1),
  GridCoordinate(column: -1, row: -1),
  GridCoordinate(column: 1, row: -1),
  GridCoordinate(column: -1, row: 1),
])
// Queen
let 👸 = PieceBase(icon: "👸", validMoves: [
  GridCoordinate(column: 0, row: Int.max),
  GridCoordinate(column: 0, row: -Int.max),
  GridCoordinate(column: Int.max, row: 0),
  GridCoordinate(column: -Int.max, row: 0),

  GridCoordinate(column: Int.max, row: Int.max),
  GridCoordinate(column: -Int.max, row: -Int.max),
  GridCoordinate(column: Int.max, row: -Int.max),
  GridCoordinate(column: -Int.max, row: Int.max),
])
// Rook
let 🏰 = PieceBase(icon: "🏰", validMoves: [
  GridCoordinate(column: 0, row: Int.max),
  GridCoordinate(column: 0, row: -Int.max),
  GridCoordinate(column: Int.max, row: 0),
  GridCoordinate(column: -Int.max, row: 0),
])
// Bishop
let 🥷 = PieceBase(icon: "🥷", validMoves: [
  GridCoordinate(column: Int.max, row: Int.max),
  GridCoordinate(column: -Int.max, row: -Int.max),
  GridCoordinate(column: Int.max, row: -Int.max),
  GridCoordinate(column: -Int.max, row: Int.max),
])
let 📍 = PieceBase(icon: "📍", validMoves: [
  GridCoordinate(column: 1, row: 1),
  GridCoordinate(column: -1, row: 1)
])
let 👉 = PieceBase(icon: "👉", validMoves: [GridCoordinate(column: 1, row: 1)])
let 🍴 = PieceBase(icon: "🍴", validMoves: [
  GridCoordinate(column: 1, row: Int.max),
  GridCoordinate(column: -1, row: Int.max),
  GridCoordinate(column: 1, row: -Int.max),
  GridCoordinate(column: -1, row: -Int.max),
])
