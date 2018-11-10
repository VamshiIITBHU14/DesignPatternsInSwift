import UIKit
import Foundation

class T20Batsman{
    
    var strikeRate : Int = 0
    
    func makeRuns() -> String{
        return (strikeRate > 130) ? "Fit for T20 Team as Batsman" : "Too slow Batsman for T20 Team"
    }
    
}

class T20Bolwer{
    
    var economyRate : Float = 0
    
    func bowlEconomically () -> String{
        return (economyRate < 8.0) ? "Fit for T20 Team as Bowler" : "Too expensive as a Bowler"
    }
    
}

class T20AllRounder : CustomStringConvertible{
    private var _strikeRate : Int = 0
    private var _economyRate : Float = 0
    
    private let t20Batsman = T20Batsman()
    private let t20Bowler = T20Bolwer()
    
    
    func makeRuns() -> String{
        return t20Batsman.makeRuns()
    }
    
    func bowlEconomically() -> String{
        return t20Bowler.bowlEconomically()
    }
    
    var strikeRate : Int{
        get {return _strikeRate}
        set(value){
            t20Batsman.strikeRate = value
            _strikeRate = value
        }
    }
    
    var economyRate : Float{
        get {return _economyRate}
        set(value){
            t20Bowler.economyRate = value
            _economyRate = value
        }
    }
    
    var description: String{
        if t20Batsman.strikeRate > 130 && t20Bowler.economyRate < 8 {
            return "Fit as T20 AllRounder"
        }
        else{
            var buffer = ""
            buffer += t20Batsman.makeRuns()
            buffer += " & " + t20Bowler.bowlEconomically()
            return buffer
        }
    }
}


func main(){
    
    let t20AllRounder = T20AllRounder()
    t20AllRounder.strikeRate = 120
    t20AllRounder.economyRate = 9
    print(t20AllRounder.description)
    
}

main()

