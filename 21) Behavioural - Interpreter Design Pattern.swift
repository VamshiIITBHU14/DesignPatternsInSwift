import UIKit
import Foundation

protocol Interpreter{
    func hasNext() -> Bool
    func next() -> String
}

protocol Container{
    func getInterpreter() -> Interpreter
}

class NameRepo : Container{
    let names = ["India" ,"Australia", "England", "NewZealand"]
    func getInterpreter() -> Interpreter {
        return NameInterpreter(names)
    }
}

private class NameInterpreter : Interpreter{
    var index = -1
    var names = [String]()
    
    init(_ names : [String]){
        self.names = names
    }
    
    func hasNext() -> Bool {
        if index < names.count {
            return true
        }
        return false
    }
    
    func next() -> String {
        if self.hasNext(){
            index = index + 1
            return names[index]
        } else{
            return ""
        }
    }
}

func main(){
    let nr = NameRepo()
    let interpreter = NameInterpreter(nr.names)
    
    for _ in nr.names{
        interpreter.hasNext()
        print(interpreter.next())
    }
}

main()

