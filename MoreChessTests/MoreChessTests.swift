//
//  MoreChessTests.swift
//  MoreChessTests
//
//  Created by Richard Adem on 26/01/2025.
//

import Testing
@testable import MoreChess

struct MoreChessTests {

  @Test func testSingleAssignment() {
    var board = Board2<Int>(columns: 8, rows: 8)
    board[0, 0] = 1

    #expect(board[0, 0] == 1)
    #expect(board[0, 1] == 0)
  }

  @Test func testInitNestedArray() throws {
    let board = try Board2(nestedArray: [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ])

    #expect(board[0, 0] == 0)
    #expect(board[1, 0] == 1)
    #expect(board[2, 0] == 2)
    #expect(board[0, 1] == 3)
    #expect(board[1, 1] == 4)
    #expect(board[2, 1] == 5)
    #expect(board[0, 2] == 6)
    #expect(board[1, 2] == 7)
    #expect(board[2, 2] == 8)
  }

  @Test func testUnbalancedNestedArray() {
    #expect(throws: Board2<Int>.BoardError.allRowsMustHaveSameLength, "Should throw if rows are unbalanced") {
      _ = try Board2(nestedArray: [
        [0, 1, 2],
        [3],
        [6, 7, 8]
      ])
    }
  }

  @Test func testIterate() throws {
    let board = try Board2(nestedArray: [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ])

    var i = 0
    for (x, y, element) in board {
      #expect(board.grid[i] == element)
      #expect(board[x, y] == element)
      i += 1
    }

  }

  @Test func testTwoByThree() throws {
    let board = try Board2(nestedArray: [
      [0, 1],
      [2, 3],
      [4, 5]
    ])

    var i = 0
    for (x, y, element) in board {
      #expect(board.grid[i] == element)
      #expect(board[x, y] == element)
      i += 1
    }

  }

  @Test func testThreebyTwo() throws {
    let board = try Board2(nestedArray: [
      [0, 1, 2],
      [3, 4, 5]
    ])

    var i = 0
    for (x, y, element) in board {
      #expect(board.grid[i] == element)
      #expect(board[x, y] == element)
      i += 1
    }

  }

  @Test func testRandomAccess() throws {
    let board = try Board2(nestedArray: [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ])

    #expect(board[0] == (0, 0, 0))
    #expect(board[1] == (1, 0, 1))
    #expect(board[2] == (2, 0, 2))
    #expect(board[3] == (0, 1, 3))
    #expect(board[4] == (1, 1, 4))
    #expect(board[5] == (2, 1, 5))
    #expect(board[6] == (0, 2, 6))
    #expect(board[7] == (1, 2, 7))
    #expect(board[8] == (2, 2, 8))

  }
}
