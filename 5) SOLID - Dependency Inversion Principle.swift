import Foundation
import UIKit

enum WicketsColumn{
    case wicketTakenBy
    case wicketGivenTo
}

class Cricketer{
    var name = ""
    
    init(_ name:String){
        self.name = name
    }
    
}

protocol WicketsTallyBrowser{
    func returnAllWicketsTakenByBowler(_ name:String) -> [Cricketer]
}

class WicketsTally : WicketsTallyBrowser { //Low Level
    private var wickets = [(Cricketer, WicketsColumn, Cricketer)]()
    
    func addToTally(_ bowler : Cricketer,_ batsman : Cricketer){
        wickets.append((bowler, .wicketTakenBy, batsman))
        wickets.append((batsman, .wicketGivenTo, bowler))
    }
    
    func returnAllWicketsTakenByBowler(_ name: String) -> [Cricketer] {
        return wickets.filter({$0.name == name && $1 == WicketsColumn.wicketTakenBy && $2 != nil})
            .map({$2})
    }
    
}
//    init(_ wicketsTally : WicketsTally){
//        let wickets = wicketsTally.wickets
//        for w in wickets where w.0.name == "BrettLee" && w.1 == .wicketTakenBy{
//            print("Brett Lee has a wicket of \(w.2.name)")
//        }
//    }
//

class PlayerStats{ //High Level
    init(_ browser : WicketsTallyBrowser){
        for w in browser.returnAllWicketsTakenByBowler("BrettLee"){
            print("Brett Lee has a wicket of \(w.name)")
        }
    }
}

func main(){
    let bowler = Cricketer("BrettLee")
    let batsman1 = Cricketer("Sachin")
    let batsman2 = Cricketer("Dhoni")
    let batsman3 = Cricketer("Dravid")
    
    let wicketsTally = WicketsTally()
    wicketsTally.addToTally(bowler, batsman1)
    wicketsTally.addToTally(bowler, batsman2)
    wicketsTally.addToTally(bowler, batsman3)
    
    let _ = PlayerStats(wicketsTally)
    
}

main()

