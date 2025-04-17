import BetterCodable
import Foundation

public typealias ChallengeList = [ChallengeBase]

// MARK: - Challenge

public struct ChallengeBase: Codable, Hashable, Identifiable {
    public let id: Int
    public let recordId: Int?
    public let title: String
    public let icon: URL
    public let level: Level
    public let isAuthor: Bool
    @DateValue<YearMonthDayStrategy>
    public var startDate: Date
    @OptionalDateValue<YearMonthDayStrategy>
    public var endDate: Date?
    public let status: ChallengeStatus
    public let entityStatus: ChallengeEntityStatus
    public let awardRatingPoints: Int?
    public let numberOfPractices: Int?
    public let completedPractices: Int?
    public let multiplier: Double?
    @DateValue<UniversalISO8601DateStrategy>
    public var created: Date

    public init(
        id: Int,
        recordId: Int?,
        title: String,
        icon: URL,
        level: Level,
        isAuthor: Bool,
        startDate: Date,
        endDate: Date?,
        status: ChallengeStatus,
        entityStatus: ChallengeEntityStatus,
        awardRatingPoints: Int?,
        numberOfPractices:Int,
        completedPractices: Int,
        multiplier: Double?,
        created: Date
    ) {
        self.id = id
        self.recordId = recordId
        self.title = title
        self.icon = icon
        self.level = level
        self.isAuthor = isAuthor
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
        self.entityStatus = entityStatus
        self.awardRatingPoints = awardRatingPoints
        self.numberOfPractices = numberOfPractices
        self.completedPractices = completedPractices
        self.multiplier = multiplier
        self.created = created
    }
}

// MARK: - ChallengeEntityStatus

public enum ChallengeEntityStatus: String, Codable, CaseIterable {
    case created
    case onModeration = "on_moderation"
    case published
    case rejected
    case running
    case completed
}

// MARK: - Mock

extension ChallengeBase {
    static let mockJson = """
    [
      {
        "award_rating_points": 12,
        "end_date": "2025-04-01",
        "entity_status": "running",
        "icon": "https://storage.yandexcloud.net/ball-in-media/cover/challenge.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250327%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250327T075345Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ad2910795439850c9b3e220ae6b781b3a60e8d08c2f9dcaa0232ecfeb96e285d",
        "id": 1,
        "is_author": false,
        "level": "beginner",
        "record_id": null,
        "start_date": "2025-03-26",
        "status": "not_started",
        "title": "Заголовок"
      },
      {
        "award_rating_points": 12,
        "end_date": "2025-04-14",
        "entity_status": "running",
        "icon": "https://storage.yandexcloud.net/ball-in-media/cover/challenge.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250327%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250327T075345Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=ad2910795439850c9b3e220ae6b781b3a60e8d08c2f9dcaa0232ecfeb96e285d",
        "id": 2,
        "is_author": false,
        "level": "beginner",
        "record_id": null,
        "start_date": "2025-03-27",
        "status": "not_started",
        "title": "title2"
      },
      {
        "award_rating_points": 10,
        "end_date": "2025-03-30",
        "entity_status": "created",
        "icon": "https://storage.yandexcloud.net/ball-in-media/cover/%D0%92%D1%8B%D0%B1%D0%BE%D1%80_%D0%BE%D0%B1%D0%BB%D0%BE%D0%B6%D0%BA%D0%B83x_iWjAeHu.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250327%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250327T075345Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=eae50394872e81c67259f9f98630bb07e877e1a31bfba8878db1a7c93bcfb118",
        "id": 6,
        "is_author": true,
        "level": "beginner",
        "record_id": null,
        "start_date": "2025-03-28",
        "status": "not_started",
        "title": "Новый челлендж"
      },
      {
        "award_rating_points": 1,
        "end_date": "2025-03-29",
        "entity_status": "created",
        "icon": "https://storage.yandexcloud.net/ball-in-media/cover/%D0%92%D1%8B%D0%B1%D0%BE%D1%80_%D0%BE%D0%B1%D0%BB%D0%BE%D0%B6%D0%BA%D0%B83x.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250327%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250327T075345Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=2575718f9787879d54f20d05bcea8507a5175f07679770d1aae435fdbf2e40c6",
        "id": 7,
        "is_author": true,
        "level": "beginner",
        "record_id": null,
        "start_date": "2025-03-28",
        "status": "not_started",
        "title": "Новейший челлендж"
      },
      {
        "award_rating_points": 10,
        "end_date": "2025-03-29",
        "entity_status": "created",
        "icon": "https://storage.yandexcloud.net/ball-in-media/cover/%D0%92%D1%8B%D0%B1%D0%BE%D1%80_%D0%BE%D0%B1%D0%BB%D0%BE%D0%B6%D0%BA%D0%B83x_pJrR1WF.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250327%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250327T075345Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=a73726472f06263430b243676133578591cde21a44922d1c095dbe3cf2bbff42",
        "id": 8,
        "is_author": true,
        "level": "beginner",
        "record_id": null,
        "start_date": "2025-03-28",
        "status": "not_started",
        "title": "Тестовый новый челлендж"
      },
      {
        "award_rating_points": 19,
        "end_date": "2025-03-30",
        "entity_status": "created",
        "icon": "https://storage.yandexcloud.net/ball-in-media/cover/%D0%92%D1%8B%D0%B1%D0%BE%D1%80_%D0%BE%D0%B1%D0%BB%D0%BE%D0%B6%D0%BA%D0%B83x_0po3gGC.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250327%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250327T075345Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=1aa00df191738fe661ecd8604e297460bce314a476a4d26b408ae58f42beea37",
        "id": 9,
        "is_author": true,
        "level": "beginner",
        "record_id": null,
        "start_date": "2025-03-28",
        "status": "not_started",
        "title": "редактированный тестовый челлендж"
      }
    ]
    """
}
