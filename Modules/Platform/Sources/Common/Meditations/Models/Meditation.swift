import Foundation

public typealias MeditationList = [Meditation]

public struct Meditation: Codable, Hashable, Identifiable {
    public let id: Int
    public let title: String
    public let timer: Int
    public let icon: URL
}

public extension Meditation {
    static let mockList: MeditationList = [
        .init(
            id: 3,
            title: "На расслабление и медитацию",
            timer: 7,
            icon: URL(
                string: "https://storage.yandexcloud.net/ball-in-media/https%3A/drive.google.com/file/d/1C99a3HUHQo6lB3oGmII51bEpuLin-tgE/view%3Fusp%3Ddrive_link?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250320%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250320T095953Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=0846c0e521f7ab2d49d65e3be19360be2f1b09320fd73f8df5e1993ff026df17"
            )!
        ),
        .init(
            id: 4,
            title: "Снятие напряжения",
            timer: 7,
            icon: URL(
                string: "https://storage.yandexcloud.net/ball-in-media/meditation/12121.jpeg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250320%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250320T095953Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=4c7121d907ced1eee41bf6a1ba9e82730811c3b3f431b7747c43ee815252efd0"
            )!
        ),
    ]
}
