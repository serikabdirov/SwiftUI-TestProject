//
//  LocalStorage.swift
//
//  Created by Zart Arn on 19.09.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import Foundation

public enum LocalStorageItemExpired {
    case `default`
    case never
}


public final class LocalStorage {
    
    private let cache = NSCache<NSString, Entry<Data>>()
    private let entryLifetime: TimeInterval
    
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    
    public init(entryLifetime: TimeInterval = 2 * 60 * 60) {
        self.entryLifetime = entryLifetime
    }
    
    // Метод для сохранения объекта в кэш
    public func saveObject<T: Codable>(_ object: T, forKey key: LocalStorageKeys, expired: LocalStorageItemExpired = .default) {
        do {
            // Кодируем объект в Data
            let data = try jsonEncoder.encode(object)
            // Устанавливаем дату истечения
            let expirationDate = calculateExpireDate(expired: expired)
            // Создаем кэшируемый элемент
            let cacheItem = Entry(object: data, expirationDate: expirationDate)
            // Сохраняем в NSCache
            cache.setObject(cacheItem, forKey: key.key as NSString)
        } catch {
            assertionFailure("Error encoding object: \(error)")
        }
    }
    
    /// Метод для получения объекта из кэша
    public func getObject<T: Codable>(forKey key: String) -> T? {
        // Проверяем, есть ли объект в кэше
        guard let cacheItem = cache.object(forKey: key as NSString) else {
            return nil
        }
        
        // Проверяем, не истек ли срок действия
        if cacheItem.expirationDate < Date() {
            // Удаляем объект, если срок истек
            cache.removeObject(forKey: key as NSString)
            return nil
        }
        
        // Декодируем объект
        do {
            let object = try jsonDecoder.decode(T.self, from: cacheItem.object)
            return object
        } catch {
            print("Error decoding object: \(error)")
            return nil
        }
    }
    
    /// Метод для удаления объекта из кэша
    public func removeObject(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    /// Очистка всего кэша
    public func clearCache() {
        cache.removeAllObjects()
    }
    
    /// Вычисление expire Date
    private func calculateExpireDate(expired: LocalStorageItemExpired) -> Date {
        switch expired {
        case .default:
            Date().addingTimeInterval(entryLifetime)
        case .never:
            Date().addingTimeInterval(24 * 60 * 60 * 365)
        }
    }
}

private extension LocalStorage {
    final class Entry<T: Codable> {
        let object: T
        let expirationDate: Date

        init(object: T, expirationDate: Date) {
            self.object = object
            self.expirationDate = expirationDate
        }
    }
}
