import Foundation

public typealias CoursesList = [CoursesListElement]

public struct CoursesListElement: Codable, Identifiable {
    public let id: Int
    public let recordId: Int?
    public let status: Status
    public let title: String
    public let icon: URL?
    public let free: Bool
    public let levels: [Level]
    public let awardPoints: Int
    public let numberOfPractices: Int
    public let completedPractices: Int
    public let awardedPoints: Int
}
