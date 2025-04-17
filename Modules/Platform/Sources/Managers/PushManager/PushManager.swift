//
//  PushManager.swift
//  Platform
//
//  Created by Zart Arn on 08.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Firebase
import Foundation
import RxCocoa
import RxRelay
import RxSwift
import UIKit

public final class PushManager: NSObject {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    private let linkManager: LinkManager
    private let service: any PushService
    private let authorizationChecker: any AuthorizationChecker
    private let fcmTokenRelay = PublishRelay<String>()

    private let disposeBag = DisposeBag()
    
    init(
        service: any PushService,
        authorizationChecker: any AuthorizationChecker,
        linkManager: LinkManager
    ) {
        self.service = service
        self.authorizationChecker = authorizationChecker
        self.linkManager = linkManager
        super.init()
        setup()
    }
    
    public func setDelegates() {
        notificationCenter.delegate = self
        Messaging.messaging().delegate = self
    }
    
    public func updateNotificationSettings(force: Bool) {
        Task {
            await updateNotificationSettings(force: force)
        }
    }

    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Private
    
    private func updateNotificationSettings(force: Bool) async {
        let settings = await notificationCenter.notificationSettings()

        switch settings.authorizationStatus {
        case .notDetermined:
            let isGranted = try? await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
            if isGranted ?? false {
                await UIApplication.shared.registerForRemoteNotifications()
            }

        case .authorized:
            await UIApplication.shared.registerForRemoteNotifications()
        case .denied where force:
            await showAlertForNotificationSettings()
        default:
            break
        }
    }

    // TODO: локализация отсутствует
    @MainActor
    private func showAlertForNotificationSettings() {
        let alert = UIAlertController(
            title: "Включите уведомления",
            message: "Чтобы получать важные сообщения, разрешите уведомления в настройках.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Настройки", style: .default) { [weak self] _ in
            self?.openAppSettings()
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        if let topVC = UIViewController.topMostController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setup() {
        Driver.combineLatest(
            authorizationChecker.isAuthorizedDriver,
            fcmTokenRelay.asDriver(onErrorDriveWith: .never())
        )
        .drive(onNext: { [weak self] isAuth, fcmToken in
            self?.registerDevice(isAuth: isAuth, fcmToken: fcmToken)
        })
        .disposed(by: disposeBag)
        
        Task {
            await updateNotificationSettings(force: false)
        }
    }
    
    private func registerDevice(isAuth: Bool, fcmToken: String) {
        Task {
            if isAuth {
                await service.registerDevice(token: fcmToken)
            } else {
                await service.unRegisterDevice(token: fcmToken)
            }
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension PushManager: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        completionHandler([.list, .banner])
    }

    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        // logger
        #if DEBUG
        let jsonObject = response.notification.request.content.userInfo
            if let prettyData = try? JSONSerialization.data(
                withJSONObject: jsonObject,
                options: .prettyPrinted
            ),
            let prettyString = String(data: prettyData, encoding: .utf8) {
                print(prettyString)
            }
        #endif
        
        // check remote nitifications
        if response.notification.request.trigger is UNPushNotificationTrigger,
           let path = response.notification.request.content.userInfo["path"] as? String {
            linkManager.handle(with: path)
        }
        completionHandler()
    }
}

// MARK: - MessagingDelegate

extension PushManager: MessagingDelegate {
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token: \(fcmToken ?? "Нет токена")")

        guard let fcmToken else { return }
        fcmTokenRelay.accept(fcmToken)
    }
}
