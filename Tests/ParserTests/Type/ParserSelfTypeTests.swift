/*
   Copyright 2016 Ryuichi Intellectual Property and the Yanagiba project contributors

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import XCTest

class ParserSelfTypeTests: XCTestCase {
  func testSelf() {
    parseTypeAndTest("Self", "Self")
  }

  func testMixedWithOtherTypes() {
    parseTypeAndTest("(Self) -> Self", "(Self) -> Self")
    parseTypeAndTest("[Self]", "Array<Self>")
    parseTypeAndTest("Self!", "ImplicitlyUnwrappedOptional<Self>")
    parseTypeAndTest("Self.Protocol", "Protocol<Self>")
  }

  func testSourceRange() {
    parseTypeAndTest("Self", "Self", testClosure: { type in
      XCTAssertEqual(type.sourceRange, getRange(1, 1, 1, 5))
    })
  }

  static var allTests = [
    ("testSelf", testSelf),
    ("testMixedWithOtherTypes", testMixedWithOtherTypes),
    ("testSourceRange", testSourceRange),
  ]
}
