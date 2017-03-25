/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

func random_uniform(value: Int) -> Int {
    return Int(arc4random_uniform(UInt32(value)))
}

enum Day: Int {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

extension Day {
    
    var name: String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
}

class Tutorial {
    
    let title: String
    var day: Day?
    
    init(title: String, day: Day? = nil) {
        self.title = title
        self.day = day
    }
}

extension Tutorial: CustomStringConvertible {
    var description: String {
        var scheduled = ", not scheduled"
        if let day = day {
            scheduled = ", scheduled on \(day)"
        }
        return title + scheduled
    }
}

func ~=(lhs: Int, rhs: Day) -> Bool {
    return lhs == rhs.rawValue + 1
}

extension Tutorial {
    
    var order: String {
        guard let day = day else {
            return "not scheduled"
        }
        switch day {
        case 1:
            return "first"
        case 2:
            return "second"
        case 3:
            return "third"
        case 4:
            return "fourth"
        case 5:
            return "fifth"
        case 6:
            return "sixth"
        case 7:
            return "seventh"
        default:
            fatalError("invalid day value")
        }
    }
}

typealias JSONObject = [String: AnyObject]
let file = Bundle.main.path(forResource:"tutorials", ofType: "json")!
let url = URL(fileURLWithPath: file)
let data = try! Data(contentsOf: url)
let json = try! JSONSerialization.jsonObject(with: data) as! [JSONObject]
print(json)

var tutorials: [Tutorial] = []

for dictionary in json {
    var currentTitle = ""
    var currentDay: Day? = nil
    
    for (key, value) in dictionary {
        // 1
        switch (key, value) {
        // 2
        case ("title", is String):
            currentTitle = value as! String
        // 3
        case ("day", let dayString as String):
            if let dayInt = Int(dayString), let day = Day(rawValue: dayInt - 1) {
                currentDay = day
            }
        // 4
        default:
            break
        }
    }
    
    let currentTutorial = Tutorial(title: currentTitle, day: currentDay)
    tutorials.append(currentTutorial)
}

print(tutorials)

tutorials.forEach { $0.day = nil }

// 1
let days = (0...6).map { Day(rawValue: $0)! }
// 2
let randomDays = days.sorted { _ in random_uniform(value: 2) == 0 }
// 3
(0...6).forEach { tutorials[$0].day = randomDays[$0] }

print(tutorials)

// 1
tutorials.sort {
    // 2
    switch ($0.day, $1.day) {
    // 3
    case (nil, nil):
        return $0.title.compare($1.title, options: .caseInsensitive) == .orderedAscending
    // 4
    case (let firstDay?, let secondDay?):
        return firstDay.rawValue < secondDay.rawValue
    // 5
    case (nil, let secondDay?):
        return true
    case (let firstDay?, nil):
        return false
    }
}

print(tutorials)

for (index, tutorial) in tutorials.enumerated() {
    guard let day = tutorial.day else {
        print("\(index + 1). \(tutorial.title) is not scheduled this week.")
        continue
    }
    print("\(index + 1). \(tutorial.title) is scheduled on \(day.name). It's the \(tutorial.order) tutorial of the week.")
}
