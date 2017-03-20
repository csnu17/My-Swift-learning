import Foundation

let cats = [ "Ellen" : "Chaplin", "Lilia" : "George Michael", "Rose" : "Friend", "Bettina" : "Pai Mei"]

cats["Ellen"] //returns Chaplin as an optional
cats["Steve"] //Returns nil

if let ellensCat = cats["Ellen"] {
    print("Ellen's cat is named \(ellensCat).")
} else {
    print("Ellen's cat's name not found!")
}

let names = ["John", "Paul", "George", "Ringo", "Mick", "Keith", "Charlie", "Ronnie"]
var stringSet = Set<String>() // 1
var loopsCount = 0
while stringSet.count < 4 {
    let randomNumber = arc4random_uniform(UInt32(names.count)) // 2
    let randomName = names[Int(randomNumber)] // 3
    print(randomName) // 4
    stringSet.insert(randomName) // 5
    loopsCount += 1 // 6
}

// 7
print("Loops: " + loopsCount.description + ", Set contents: " + stringSet.description)

let countedMutable = NSCountedSet()
for name in names {
    countedMutable.add(name)
    countedMutable.add(name)
}

let ringos = countedMutable.count(for: "Ringo")
print("Counted Mutable set: \(countedMutable)) with count for Ringo: \(ringos)")

let items : NSArray = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]

let indexSet = NSMutableIndexSet()
indexSet.add(3)
indexSet.add(8)
indexSet.add(9)

items.objects(at: indexSet as IndexSet) // returns ["four", "nine", "ten"]