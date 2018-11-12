import Foundation

class Cricketer : CustomStringConvertible{
    var name : String
    var battingSkillRating : Int
    var bowlingSkillRating : Int
    var fieldingSkillRating : Int
    
    init(_ name:String, _ battingSkillRating:Int, _ bowlingSkillRating:Int, _ fieldingSkillRating:Int) {
        self.name = name
        self.battingSkillRating = battingSkillRating
        self.bowlingSkillRating  =  bowlingSkillRating
        self.fieldingSkillRating = fieldingSkillRating
    }
    
    var description: String{
        return "Cricketer : \(name) with battingRating : \(battingSkillRating), bowlingRating : \(bowlingSkillRating), fieldingRating : \(fieldingSkillRating)"
    }
}

class SkillBooster{
    let cricketer : Cricketer
    var skillBooster : SkillBooster?
    
    init(_ cricketer : Cricketer) {
        self.cricketer = cricketer
    }
    
    func addBooster(_ booster : SkillBooster){
        if skillBooster != nil{
            skillBooster!.addBooster(booster)
        } else{
            skillBooster = booster
        }
    }
    
    func playTheGame(){
        skillBooster?.playTheGame()
    }
}


class BattingSkillBooster : SkillBooster{
    override func playTheGame() {
        print("Adding Hook Shot to \(cricketer.name) 's Batting")
        cricketer.battingSkillRating += 1
        super.playTheGame()
    }
}

class BowlingSkillBooster : SkillBooster{
    override func playTheGame() {
        print("Adding Reverse Swing to \(cricketer.name) 's Bowling")
        cricketer.bowlingSkillRating += 1
        super.playTheGame()
    }
}

class FieldingSkillBooster : SkillBooster{
    override func playTheGame() {
        print("Adding Dive Catches to \(cricketer.name) 's Fielding")
        cricketer.fieldingSkillRating += 1
        super.playTheGame()
    }
}

class NoSkillBooster : SkillBooster{
    override func playTheGame() {
        print("No boosters available here")
        //don't call super
    }
}


//    let skillBooster = SkillBooster(dhoni)
//
//    // later
//    skillBooster.addBooster(NoSkillBooster(dhoni))
//
//    print("Adding Batting Booster to Dhoni")
//    skillBooster.addBooster(BattingSkillBooster(dhoni))
//
//    print("Adding Bowling Booster to Dhoni")
//    skillBooster.addBooster(BowlingSkillBooster(dhoni))
//
//
//    print("Adding Fielding Booster to Dhoni")
//    skillBooster.addBooster(FieldingSkillBooster(dhoni))
//    skillBooster.playTheGame()
//    print(dhoni)

//print("Adding Bowling Booster to Dhoni")
//skillBooster.addBooster(BowlingSkillBooster(dhoni))
//skillBooster.playTheGame()
//print(dhoni.description)

func main(){
    
    let dhoni = Cricketer("Dhoni", 6, 3, 7)
    
    let skillBooster = SkillBooster(dhoni)
    
    print("Adding Batting Booster to Dhoni")
    skillBooster.addBooster(BattingSkillBooster(dhoni))
    
    print("Adding Bowling Booster to Dhoni")
    skillBooster.addBooster(BowlingSkillBooster(dhoni))
    skillBooster.playTheGame()
    print(dhoni.description)
}

main()

