import UIKit

struct Cricketer{
    let name : String
    let team : String
}

struct Cricketers{
    let cricketers : [Cricketer]
}

struct CricketersIterator : IteratorProtocol{
    
    private var current = 0
    private let cricketers : [Cricketer]
    
    init(_ cricketers : [Cricketer]) {
        self.cricketers = cricketers
    }
    
    mutating func next() -> Cricketer? {
        defer {
            current += 1
        }
        if cricketers.count > current{
            return cricketers[current]
        } else{
            return nil
        }
    }
    
}

extension Cricketers : Sequence{
    func makeIterator() -> CricketersIterator {
        return CricketersIterator(cricketers)
    }
}

func main(){
    let cricketers = Cricketers(cricketers: [Cricketer(name: "Kohli", team: "India"), Cricketer(name: "Steve", team: "Australia"), Cricketer(name: "Kane", team: "Kiwis"), Cricketer(name: "Root", team: "England")])
    for crick in cricketers{
        print(crick)
    }
}

main()

