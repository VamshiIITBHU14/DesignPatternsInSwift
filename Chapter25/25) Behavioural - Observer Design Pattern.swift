import Foundation

protocol Invocable : class
{
    func invoke(_ data: Any)
}

public protocol Disposable
{
    func dispose()
}

public class Event<T>
{
    public typealias EventHandler = (T) -> ()
    
    var eventHandlers = [Invocable]()
    
    public func raise(_ data: T)
    {
        for handler in eventHandlers
        {
            handler.invoke(data)
        }
    }
    
    public func addHandler<U: AnyObject>
        (target: U, handler: @escaping (U) -> EventHandler) -> Disposable
    {
        let subscription = Subscription(
            target: target, handler: handler, event: self)
        eventHandlers.append(subscription)
        return subscription
    }
}

class Subscription<T: AnyObject, U> : Invocable, Disposable
{
    weak var target: T? // note: weak reference!
    let handler: (T) -> (U) -> ()
    let event: Event<U>
    
    init(target: T?,
         handler: @escaping (T) -> (U) -> (),
         event: Event<U>)
    {
        self.target = target
        self.handler = handler
        self.event = event
    }
    
    func invoke(_ data: Any) {
        if let t = target {
            handler(t)(data as! U)
        }
    }
    
    func dispose()
    {
        event.eventHandlers = event.eventHandlers.filter { $0 as AnyObject? !== self }
    }
}

class ScoreBoardInTheGround{
    let batsmenHitRun = Event<Int>()
    init(){}
    func updateScore(){
        
    }
}

class ScoreUpdateInServers{
    init(){
        let scoreBoard = ScoreBoardInTheGround()
        let subscriber = scoreBoard.batsmenHitRun.addHandler(target: self, handler: ScoreUpdateInServers.showScoreInApp)
        
        //simualte batsman hitting runs in the ground
        scoreBoard.batsmenHitRun.raise(6)
        
        //get rid of the description
        subscriber.dispose()
    }
    
    func showScoreInApp(score: Int){
        print("Score Now is : \(score) runs")
    }
}

func main(){
    let dummy = ScoreUpdateInServers()
}

main()

