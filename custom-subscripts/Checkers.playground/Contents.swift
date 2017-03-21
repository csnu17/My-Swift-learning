import Foundation

struct Checkerboard {
    
    enum Square: String {
        case empty = "▪️"
        case red = "🔴"
        case white = "⚪️"
    }
    
    typealias Coordinate = (x: Int, y: Int)
    
    fileprivate var squares: [[Square]] = [
        [ .empty, .red,   .empty, .red,   .empty, .red,   .empty, .red   ],
        [ .red,   .empty, .red,   .empty, .red,   .empty, .red,   .empty ],
        [ .empty, .red,   .empty, .red,   .empty, .red,   .empty, .red   ],
        [ .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty ],
        [ .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty ],
        [ .white, .empty, .white, .empty, .white, .empty, .white, .empty ],
        [ .empty, .white, .empty, .white, .empty, .white, .empty, .white ],
        [ .white, .empty, .white, .empty, .white, .empty, .white, .empty ]
    ]
    
    subscript(coordinate: Coordinate) -> Square {
        get {
            return squares[coordinate.y][coordinate.x]
        }
        set {
            squares[coordinate.y][coordinate.x] = newValue
        }
    }
    
    subscript(x: Int, y: Int) -> Square {
        get {
            return self[(x: x, y: y)]
        }
        set {
            self[(x: x, y: y)] = newValue
        }
    }
}

extension Checkerboard: CustomStringConvertible {
    
    var description: String {
        return squares.map { row in row.map { $0.rawValue }.joined(separator: "") }
            .joined(separator: "\n") + "\n"
    }
}

var checkerboard = Checkerboard()
print(checkerboard)

let coordinate = (x: 3, y: 2)
print(checkerboard[coordinate])
checkerboard[coordinate] = .white
print(checkerboard)

print(checkerboard[1, 2])
checkerboard[1, 2] = .white
print(checkerboard)