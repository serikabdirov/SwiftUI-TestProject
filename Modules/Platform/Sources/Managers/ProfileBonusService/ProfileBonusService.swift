
public protocol ProfileBonusService {
    func getBonusBalance() async throws -> ProfileBonusBalance
}
