import Foundation
import UIKit

protocol Batsman
{
    func makeRuns(_ numberOfBalls: Int)
}

class TestBatsman : Batsman
{
    
    func makeRuns(_ numberOfBalls: Int) {
        print("I am a Test Batsman and I score \(0.6 * Double(numberOfBalls)) runs in \(numberOfBalls) balls")
    }
}

class ODIBatsman : Batsman
{
    func makeRuns(_ numberOfBalls: Int) {
        print("I am a ODI Batsman and I score \(1 * Double(numberOfBalls)) runs in \(numberOfBalls) balls")
    }
}

class T20IBatsman : Batsman
{
    func makeRuns(_ numberOfBalls: Int) {
        print("I am a T20 Batsman and I score \(1.4 * Double(numberOfBalls)) runs in \(numberOfBalls) balls")
    }
}


protocol Player
{
    func play()
    
}

class Cricketer : Player
{
    var numberOfBalls: Int
    var batsman: Batsman
    
    init(_ batsman: Batsman, _ numberOfBalls: Int)
    {
        self.batsman = batsman
        self.numberOfBalls = numberOfBalls
    }
    
    func play() {
        batsman.makeRuns(numberOfBalls)
    }
    
}




func main()
{
    let testBatsman = TestBatsman()
    let odiBatsman = ODIBatsman()
    let t20Batsman = T20IBatsman()
    
    let cricketer1 = Cricketer(testBatsman, 20)
    let cricketer2 = Cricketer(odiBatsman, 20)
    let cricketer3 = Cricketer(t20Batsman, 20)
    
    cricketer1.play()
    cricketer2.play()
    cricketer3.play()
    
}

main()

