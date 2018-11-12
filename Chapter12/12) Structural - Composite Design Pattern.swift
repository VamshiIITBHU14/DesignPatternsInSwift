import UIKit
import Foundation

class CricketTeamMember : CustomStringConvertible{
    
    var name : String
    var role : String
    var grade : String
    var teamMembers : [CricketTeamMember]
    
    init(name:String, role : String, grade : String) {
        self.name = name
        self.role = role
        self.grade = grade
        self.teamMembers = [CricketTeamMember]()
    }
    
    func addMember(member : CricketTeamMember){
        teamMembers.append(member)
    }
    
    func removeMember(member : CricketTeamMember){
        teamMembers.append(member)
    }
    
    func getListOfTeamMembers() -> [CricketTeamMember]{
        return teamMembers
    }
    var description: String
    {
        let demo = "\(name)  \(role) \(grade)"
        return demo
        
    }
}

func main(){
    let headCoach = CricketTeamMember(name: "HeadCoach", role: "HeadCoach", grade: "A")
    let captain = CricketTeamMember(name: "TeamCaptain", role: "Captain", grade: "B")
    let bowlingCoach = CricketTeamMember(name: "BowlingCoach", role: "Coach", grade: "B")
    let battingCoach = CricketTeamMember(name: "BattingCoach", role: "Coach", grade: "B")
    let fieldingCoach = CricketTeamMember(name: "FieldingCoach", role: "Coach", grade: "B")
    let asstBowlingCoach = CricketTeamMember(name: "ABoC1", role: "AsstCoach", grade: "C")
    let asstBattingCoach = CricketTeamMember(name: "ABaC1", role: "AsstCoach", grade: "C")
    let asstFieldingCoach = CricketTeamMember(name: "ABfC1", role: "AsstCoach", grade: "C")
    let teamMember1 = CricketTeamMember(name: "TM1", role: "Player", grade: "B")
    let teamMember2 = CricketTeamMember(name: "TM2", role: "Player", grade: "B")
    
    headCoach.addMember(member: captain)
    headCoach.addMember(member: bowlingCoach)
    headCoach.addMember(member: battingCoach)
    headCoach.addMember(member: fieldingCoach)
    
    captain.addMember(member: teamMember1)
    captain.addMember(member: teamMember2)
    
    bowlingCoach.addMember(member: asstBowlingCoach)
    battingCoach.addMember(member: asstBattingCoach)
    fieldingCoach.addMember(member: asstFieldingCoach)
    
    print(headCoach.description)
    for member in headCoach.getListOfTeamMembers(){
        print(member.description)
        for member in member.getListOfTeamMembers(){
            print(member.description)
        }
    }
}

main()


