import Foundation

enum RideCategory: String {
  case family, kids, thrill, scary, relaxing, water
}

extension RideCategory: CustomStringConvertible {
  var description: String {
    return rawValue
  }
}

typealias Minutes = Double
struct Ride: Comparable {
  let name: String
  let categories: Set<RideCategory>
  let waitTime: Minutes
  
  static func <(lhs: Ride, rhs: Ride) -> Bool {
    return lhs.waitTime < rhs.waitTime
  }
  
  static func ==(lhs: Ride, rhs: Ride) -> Bool {
    return lhs.name == rhs.name
  }
}

extension Ride: CustomStringConvertible {
  var description: String {
    return "⚡️Ride(name: \"\(name)\", waitTime: \(waitTime), categories: \(categories))"
  }
}

extension Array where Element: Comparable {
  func quickSorted() -> [Element] {
    if self.count > 1 {
      let (pivot, remaining) = (self[0], dropFirst())
      let lhs = remaining.filter { $0 <= pivot }
      let rhs = remaining.filter { $0 > pivot }
      return lhs.quickSorted() as [Element] + [pivot] + rhs.quickSorted()
    }
    return self
  }
}

let parkRides = [
  Ride(name: "Raging Rapids", categories: [.family, .thrill, .water], waitTime: 45.0),
  Ride(name: "Crazy Funhouse", categories: [.family], waitTime: 10.0),
  Ride(name: "Spinning Tea Cups", categories: [.kids], waitTime: 15.0),
  Ride(name: "Spooky Hollow", categories: [.scary], waitTime: 30.0),
  Ride(name: "Thunder Coaster", categories: [.family, .thrill], waitTime: 60.0),
  Ride(name: "Grand Carousel", categories: [.family, .kids], waitTime: 15.0),
  Ride(name: "Bumper Boats", categories: [.family, .water], waitTime: 25.0),
  Ride(name: "Mountain Railroad", categories: [.family, .relaxing], waitTime: 0.0)
]

print(parkRides.quickSorted())
print(parkRides)
print("==================================")

func waitTimeisShort(ride: Ride) -> Bool {
  return ride.waitTime < 15.0
}

//var shortWaitTimeRides = parkRides.filter(waitTimeisShort)
var shortWaitTimeRides = parkRides.filter { $0.waitTime < 15.0 }
print(shortWaitTimeRides)

func sortedNames(of rides: [Ride]) -> [String] {
  let rideNames = rides.map { $0.name }
  return rideNames.sorted(by: <)
}

print(sortedNames(of: parkRides))

let totalWaitTime = parkRides.reduce(0.0) { (total, ride) in
  total + ride.waitTime
}
print(totalWaitTime)

func filter(for category: RideCategory) -> ([Ride]) -> [Ride] {
  return { (rides: [Ride]) in
    rides.filter { $0.categories.contains(category) }
  }
}

let kidRideFilter = filter(for: .kids)
print(kidRideFilter(parkRides))

func ridesWithWaitTimeUnder(_ waitTime: Minutes, from rides: [Ride]) -> [Ride] {
  return rides.filter { $0.waitTime < waitTime }
}

var shortWaitRides = ridesWithWaitTimeUnder(15, from: parkRides)
assert(shortWaitRides.count == 2, "Count of short wait rides should be 2")
print(shortWaitRides)

/*
let rideNames = parkRides.map { $0.name }
print(rideNames)
print(rideNames.sorted(by: <))
*/
 
/*
func sortedNames(of rides: [Ride]) -> [String] {
  var sortedRides = rides
  var key: Ride
  
  for i in 0 ..< sortedRides.count {
    key = sortedRides[i]
    
    for j in stride(from: i, to: -1, by: -1) {
      if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
        sortedRides.remove(at: j + 1)
        sortedRides.insert(key, at: j)
      }
    }
  }
  
  var sortedNames = [String]()
  for ride in sortedRides {
    sortedNames.append(ride.name)
  }
  
  return sortedNames
}

print(sortedNames(of: parkRides))
var originalNames = [String]()
for ride in parkRides {
  originalNames.append(ride.name)
}
 
print(sortedNames(of: parkRides))
print(originalNames)
*/
 
