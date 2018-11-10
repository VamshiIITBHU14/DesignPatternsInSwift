import UIKit
import Foundation

protocol Command{
    func displayStatus()
}

protocol RemoteUmpire{
    func registerTVDisplay(tvDisplay :TVDisplay)
    func registerTVOperator(tvOperator : TVOperator)
    func isDecisionMade() -> Bool
    func setDecisionStatus(status : Bool)
}

class TVOperator : Command{
    var tvUmpire:TVUmpire
    
    init(_ tvUmpire : TVUmpire){
        self.tvUmpire = tvUmpire
    }
    
    func displayStatus() {
        if tvUmpire.isDecisionMade(){
            print("Decision Made and Batsman in OUT")
            tvUmpire.setDecisionStatus(status: true)
        } else{
            print("Decision Pending")
        }
    }
    
    func getReady(){
        print("Ready to Display Decision")
    }
}

class TVDisplay : Command{
    var tvUmpire:TVUmpire
    
    init(_ tvUmpire : TVUmpire) {
        self.tvUmpire = tvUmpire
        tvUmpire.setDecisionStatus(status: true)
    }
    func displayStatus() {
        print("Decision made and permission granted to display the decision on TV Display")
        tvUmpire.setDecisionStatus(status: true)
    }
}



class TVUmpire : RemoteUmpire{
    private var tvOperator : TVOperator?
    private var tvDisplay : TVDisplay?
    private var decisionMade : Bool?
    
    func registerTVDisplay(tvDisplay: TVDisplay) {
        self.tvDisplay = tvDisplay
    }
    
    func registerTVOperator(tvOperator: TVOperator) {
        self.tvOperator = tvOperator
    }
    
    func isDecisionMade() -> Bool {
        return decisionMade!
    }
    
    func setDecisionStatus(status: Bool) {
        self.decisionMade = status
    }
}

func main(){
    let tvUmpire = TVUmpire()
    let tvDisplayAtGround = TVDisplay(tvUmpire)
    let tvOperatorAtGround = TVOperator(tvUmpire)
    tvUmpire.registerTVDisplay(tvDisplay: tvDisplayAtGround)
    tvUmpire.registerTVOperator(tvOperator: tvOperatorAtGround)
    tvOperatorAtGround.getReady()
    tvDisplayAtGround.displayStatus()
    tvOperatorAtGround.displayStatus()
    
    
}

main()



