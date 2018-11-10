import UIKit
import Foundation

protocol Coach
{
    func mentorTheTeam()
}

class CricketCoach : Coach
{
    
    func mentorTheTeam() {
        print("Mentoring the Cricket Team")
    }
    
}

class CricketCoachProxy : Coach
{
    private let cricketCoach = CricketCoach()
    private let coachApplicant: CoachApplicant
    
    init(coachApplicant: CoachApplicant)
    {
        self.coachApplicant = coachApplicant
    }
    
    func mentorTheTeam() {
        if coachApplicant.numberOfYearsOfExperience >= 8{
            cricketCoach.mentorTheTeam()
        } else{
            print("Not enough experience to coach the team")
        }
    }
    
}

class CoachApplicant
{
    var numberOfYearsOfExperience: Int
    
    init(numberOfYearsOfExperience: Int)
    {
        self.numberOfYearsOfExperience = numberOfYearsOfExperience
    }
}

func main()
{
    let coach : Coach = CricketCoachProxy(coachApplicant: CoachApplicant(numberOfYearsOfExperience: 5))
    coach.mentorTheTeam()
}

main()

