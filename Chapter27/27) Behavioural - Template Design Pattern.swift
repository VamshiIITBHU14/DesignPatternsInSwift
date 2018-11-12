import UIKit
import Foundation

class TeamTemplate{
    func buildTeam(){
        pickBatsmen()
        pickBowlers()
        pickAllRounders()
        pickWicketKeeper()
        print("\nTeam Set For the match")
    }
    
    func pickBatsmen(){
        
    }
    
    func pickBowlers(){
        
    }
    
    func pickAllRounders(){
        
    }
    
    private func pickWicketKeeper(){
        print("Only one WK avaialable and he is picked by default")
    }
}

class SeamingPitchTeamTemplate : TeamTemplate{
    override func pickBatsmen() {
        print("Picking 6 batsmen")
    }
    
    override func pickBowlers() {
        print("Picking 3 Fast Bowlers")
    }
    
    override func pickAllRounders() {
        print("Picking 1 Pace AllRounder")
    }
}

class SpinPitchTeamTemplate : TeamTemplate{
    override func pickBatsmen() {
        print("Picking 5 Batsmen")
    }
    
    override func pickBowlers() {
        print("Picking 2 Fast Bowlers and 2 Spinners")
    }
    
    override func pickAllRounders() {
        print("Picking 2 Spin AllRounder")
    }
}

class BattingPitchTeamTemplate : TeamTemplate{
    override func pickBatsmen() {
        print("Picking 7 Batsmen")
    }
    
    override func pickBowlers() {
        print("Picking 2 Fast Bowlers and 1 Spinners")
    }
    
    override func pickAllRounders() {
        print("Picking 1 Batting AllRounder")
    }
}

func main(){
    var finalTeam : TeamTemplate = SeamingPitchTeamTemplate()
    finalTeam.buildTeam()
    
    print("\n***Pitch Changed***\n")
    finalTeam = SpinPitchTeamTemplate()
    finalTeam.buildTeam()
    
    print("\n***Pitch Changed***\n")
    finalTeam = BattingPitchTeamTemplate()
    finalTeam.buildTeam()
}

main()

