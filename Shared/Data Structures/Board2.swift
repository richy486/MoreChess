//
//  Matrix.swift
//  MoreChess
//
//  Created by Richard Adem on 26/01/2025.
//

// columns = x
// rows = y
struct Board2<T> {

  enum BoardError: Error {
    case indexOutOfBounds
    case rowsMustBePositive
    case columnsMustBePositive
    case allRowsMustHaveSameLength
  }

  let columns: Int
  let rows: Int
  var grid: [T]



  init(columns: Int, rows: Int, defaultValue: T) {
    self.columns = columns
    self.rows = rows
    grid = Array(repeating: defaultValue, count: columns * rows)
  }
  init(columns: Int, rows: Int) where T: Numeric {
    self.columns = columns
    self.rows = rows
    grid = Array(repeating: T.zero, count: columns * rows)
  }
  init(nestedArray: [[T]]) throws {
    self.columns = nestedArray[0].count
    self.rows = nestedArray.count
    grid = nestedArray.flatMap(\.self)

    guard rows > 0 else { throw BoardError.rowsMustBePositive }
    guard columns > 0 else { throw BoardError.columnsMustBePositive }
    if rows > 1 {
      if nestedArray.dropFirst().allSatisfy({ $0.count == columns }) == false {
        throw BoardError.allRowsMustHaveSameLength
      }
    }
  }

  func indexIsValid(column: Int, row: Int) -> Bool {
    return column >= 0 && column < columns && row >= 0 && row < rows
  }
  subscript(column: Int, row: Int) -> T {
    get {
      assert(indexIsValid(column: column, row: row), "Index out of range column: \(column) row: \(row)")
      return grid[(row * columns) + column]
    }
    set {
      assert(indexIsValid(column: column, row: row), "Index out of range column: \(column) row: \(row)")
      grid[(row * columns) + column] = newValue
    }
  }
}

extension Board2: Sequence {
  func makeIterator() -> Iterator {
    return Iterator(board: self)
  }

  struct Iterator: IteratorProtocol {
    private let board: Board2
    private var x = 0
    private var y = 0

    init(board: Board2) {
      self.board = board
    }

    mutating func next() -> (Int, Int, T)? {
      guard y < board.rows else { return nil }
      let element = board[x, y]
      let result = (x, y, element)

      x += 1
      if x >= board.columns {
        x = 0
        y += 1
      }

      return result
    }
  }
}

extension Board2: RandomAccessCollection {
  // Conformance to Collection
  typealias Index = Int
  typealias ElementTuple =  (Int, Int, T)

  var startIndex: Index { 0 }
  var endIndex: Index { grid.count }

  func index(after i: Index) -> Index {
    i + 1
  }

  // Conformance to RandomAccessCollection
  func index(before i: Index) -> Index {
    i - 1
  }

  subscript(position: Index) -> ElementTuple {
    precondition(position >= startIndex && position < endIndex, "Index out of bounds")

    let x = position % columns
    let y = position / columns

    assert(indexIsValid(column: x, row: y), "Index out of range column: \(x) row: \(y)")
    return (x: x, y: y, element: grid[position])

//    fatalError("Index calculation error")
  }
}
