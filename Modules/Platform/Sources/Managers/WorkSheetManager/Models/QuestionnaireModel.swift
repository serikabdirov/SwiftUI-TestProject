import Foundation
import BetterCodable

public struct QuestionnaireModel: Codable {
    public var cityId: Int?
    public var city: City?
    public var firstName: String
    public var lastName: String
    @DateValue<YearMonthDayStrategy>
    public var birthDate: Date
    public var weight: Double
    public var weightUnit: WeightUnits
    public var height: Double
    public var heightUnit: HeightUnits
    public var level: Level
    public var position: [PositionType]
    public var trainingDirection: [TrainingDirectionEnum]
    public var kickLeg: KickLegType
    public var trainingGoal: TrainingGoalEnum
    public var favoriteFc: String
    public var participateInSections: Bool
    public var experience: ExperienceEnum
    public var email: String
    public var nickname: String

    public init(
        cityId: Int,
        firstName: String,
        lastName: String,
        birthDate: Date,
        weight: Double,
        weightUnit: WeightUnits,
        height: Double,
        heightUnit: HeightUnits,
        level: Level,
        position: [PositionType],
        trainingDirection: [TrainingDirectionEnum],
        kickLeg: KickLegType,
        trainingGoal: TrainingGoalEnum,
        favoriteFc: String,
        participateInSections: Bool,
        experience: ExperienceEnum,
        email: String,
        nickname: String) {
            
            self.cityId = cityId
            self.firstName = firstName
            self.lastName = lastName
            self.birthDate = birthDate
            self.weight = weight
            self.weightUnit = weightUnit
            self.height = height
            self.heightUnit = heightUnit
            self.level = level
            self.position = position
            self.trainingDirection = trainingDirection
            self.kickLeg = kickLeg
            self.trainingGoal = trainingGoal
            self.favoriteFc = favoriteFc
            self.participateInSections = participateInSections
            self.experience = experience
            self.email = email
            self.nickname = nickname
        }
}

public struct Country: Codable, Equatable, Hashable {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public struct City: Codable, Equatable {
    public var id: Int
    public var name: String
    public var country: Country?
}

public enum TrainingDirectionEnum: String, Codable, CaseIterable {
    case speed
    case dribbling
    case kicks
    case complexExercises = "complex_exercises"
}

public enum TrainingGoalEnum: String, Codable, CaseIterable {
    case maintainingPhysicalFitness = "maintaining_physical_fitness"
    case amateurSports = "amateur_sports"
    case developingFootballSkills = "developing_football_skills"
    case workingOnWeaknesses = "working_on_weaknesses"
}

public enum ExperienceEnum: String, Codable, CaseIterable {
    case to1 = "to_1"
    case from1To3 = "from_1_to_3"
    case from3To5 = "from_3_to_5"
    case from5 = "from_5"
}
