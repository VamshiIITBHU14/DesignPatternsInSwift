import UIKit
//Assume there is a BowlingMachine which delivers Red Cricket Balls (used for Test Cricket) and White Crikcet Balls (used for Limited Overs Cricket) based on user input.

protocol CricketBall{
    func hitMe()
}

class RedBall : CricketBall{
    func hitMe() {
        print("This ball is good for Test Cricket")
    }
}

class WhiteBall : CricketBall{
    func hitMe() {
        print("This ball is good for Limited Overs Cricket")
    }
}

protocol CricketBallFactory{
    init()
    //We can also give some input like the speed at which we want the ball to be delivered
    func deliverTheBall (_ speed : Int) -> CricketBall
}

class RedBallFactory{
    func deliverTheBall (_ speed : Int) -> CricketBall{
        print("Releasing Red Ball at \(speed) speed")
        return RedBall()
    }
}

class WhiteBallFactory{
    func deliverTheBall (_ speed : Int) -> CricketBall{
        print("Releasing White Ball at \(speed) speed")
        return WhiteBall()
    }
}

//Now we go to the machine and give an input to deliver the balls
class BowlingMachine{
    enum AvailableBall : String{ //breaks Open Closed Principle
        case redBall = "RedBall"
        case whiteBall = "WhiteBall"
        
        static let all = [redBall, whiteBall]
    }
    
    internal var factories = [AvailableBall : CricketBallFactory]()
    internal var namedFactories = [(String, CricketBallFactory)] ()
    
    init() {
        for ball in AvailableBall.all{
            let type = NSClassFromString("FactoryDesignPattern.\(ball.rawValue)Factory")
            let factory = (type as! CricketBallFactory.Type).init()
            factories[ball] = factory
            namedFactories.append((ball.rawValue, factory))
        }
    }
    
    func setTheBall () -> CricketBall{
        for i in 0..<namedFactories.count{
            let tuple = namedFactories[i]
            print("\(i) : \(tuple.0)")
        }
        
        let input = Int(readLine()!)!
        return namedFactories[input].1.deliverTheBall(120)
        
    }
}


func main(){
    let bowlingMachine = BowlingMachine()
    print(bowlingMachine.namedFactories.count)
    let ball = bowlingMachine.setTheBall()
    ball.hitMe()
}

main()

