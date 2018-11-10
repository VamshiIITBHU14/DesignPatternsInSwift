import UIKit

enum CricketBall : String{
    case slow = "Yellow"
    case medium = "Green"
    case fast = "Red"
}

protocol ReleaseCricketBallStrategy{
    var speed : String {get set}
    var cricketBall : CricketBall {get set}
    func releaseBall() -> String
}

class FastBallStrategy : ReleaseCricketBallStrategy{
    
    var speed = "Fast"
    var cricketBall = CricketBall.fast
    init(){}
    
    func releaseBall() -> String {
        return "Released \(speed) ball with color \(cricketBall.rawValue)"
    }
}

class MediumBallStrategy : ReleaseCricketBallStrategy{
    var speed = "Medium"
    var cricketBall = CricketBall.medium
    init(){}
    
    func releaseBall() -> String {
        return "Released \(speed) ball with color \(cricketBall.rawValue)"
    }
}

class SlowBallStrategy : ReleaseCricketBallStrategy{
    var speed = "Slow"
    var cricketBall = CricketBall.slow
    init(){}
    
    func releaseBall() -> String {
        return "Released \(speed) ball with color \(cricketBall.rawValue)"
    }
}

class BowlingMachine : CustomStringConvertible {
    private var releaseCricketBallStrategy : ReleaseCricketBallStrategy
    private var returnString = ""
    
    init(whatStrategy : ReleaseCricketBallStrategy){
        self.releaseCricketBallStrategy = whatStrategy
        returnString = releaseCricketBallStrategy.releaseBall()
    }
    var description: String{
        return returnString
    }
}

func main(){
    var bowlingMachine = BowlingMachine(whatStrategy: FastBallStrategy())
    print(bowlingMachine.description)
    
    bowlingMachine = BowlingMachine(whatStrategy: SlowBallStrategy())
    print(bowlingMachine.description)
    
    bowlingMachine = BowlingMachine(whatStrategy: MediumBallStrategy())
    print(bowlingMachine.description)
    
}

main()



