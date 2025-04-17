import Foundation
import R

public enum WorkSheetCoordinatorStep: Int {
    case aboutMe
    case birthday
    case location
    case bodyParameters
    case levelFootball
    case positionOnTheField
    case directionOfTraining
    case kickLeg
    case purposeOfPlaying
    case favoriteClub
    case playFootball
    case experienceFootball
    case email
    case nickname
    case finish
    
    public init?(raw: Int) {
        self.init(rawValue: raw)
    }
}

public extension WorkSheetCoordinatorStep {
    var screenTitle: String {
        switch self {
        case .aboutMe: return RStrings.Ls.Profile.Form.Personal.Name.And.surname
        case .location: return RStrings.Ls.Profile.Form.Personal.location
        case .bodyParameters: return RStrings.Ls.Profile.Form.Sport.Your.parameters
        case .levelFootball: return RStrings.Ls.Profile.Form.Sport.level
        case .positionOnTheField: return RStrings.Ls.Profile.Form.Sport.position
        case .directionOfTraining: return RStrings.Ls.Profile.Form.Sport.Training.direction
        case .kickLeg: return RStrings.Ls.Profile.Form.Sport.leg
        case .purposeOfPlaying: return RStrings.Ls.Profile.Form.Sport.goal
        case .favoriteClub: return RStrings.Ls.Profile.Form.Sport.Favorite.club
        case .playFootball: return RStrings.Ls.Profile.Form.Sport.sections
        case .experienceFootball: return RStrings.Ls.Profile.Form.Sport.experience
        case .email: return RStrings.Ls.Profile.Form.Personal.email
        case .nickname: return RStrings.Ls.Profile.Form.Personal.nickname
        case .finish: return " "
        case .birthday: return " "
        }
    }
}
