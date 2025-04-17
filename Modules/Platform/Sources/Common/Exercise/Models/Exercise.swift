import Foundation
import R

public struct Exercise: Codable, Identifiable, Hashable {
    public var id: Int
    public let recordId: Int?
    public let status: ExerciseStatus
    public let title: String
    public let description: String
    public let level: Level
    public let icon: URL?
    public let video: URL?
    public let categories: [String]
    public let inventory: [String]
    public let awardPoints: Int
    public let participants: Participants
    public let positions: [PositionType]
    public let approachTime: Int?
    public let repetitions: Int?
    public let numberOfApproaches: Int

    public enum Participants: String, Codable {
        case one
        case twoOrMore = "two_or_more"

        public var title: String {
            switch self {
            case .one:
                RStrings.Ls.Exercise.Detail.Participants.one
            case .twoOrMore:
                RStrings.Ls.Exercise.Detail.Participants.Two.Ore.more
            }
        }
    }
}

public enum ExerciseStatus: String, CaseIterable, Codable {
    case completed
    case notCompleted = "not_completed"
}
