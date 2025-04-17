//
//  MeditationDetail.swift
//  Meditations
//
//  Created by Александр Болотов on 18.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation

public struct MeditationDetail: Codable, Hashable, Identifiable {
    public let id: Int
    public let title: String
    public let timer: Int
    public let icon: URL
    public let description: String
    public let audio: URL
    public let cover: URL
}

public extension MeditationDetail {
    static let mockData: [MeditationDetail] = [
        .init(
            id: 4,
            title: "Снятие напряжения",
            timer: 7,
            icon: URL(
                string: "https://storage.yandexcloud.net/ball-in-media/meditation/12121.jpeg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250321%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250321T074255Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=c906b255c417e8c88741175dd223a70aa8feec7ff22c3adb692ac675e8af0c7b"
            )!,

            description: "Снятие напряжения описание",
            audio: URL(
                string: "https://storage.yandexcloud.net/ball-in-media/meditation/perfect-beauty-191271.mp3?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250321%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250321T074255Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=c9a1ebbe3b44f49ac064f1d12cb8db19d4df2fcc152e24caca360c477021e693"
            )!,
            cover: URL(
                string: "https://storage.yandexcloud.net/ball-in-media/meditation/16-2500x1667.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEO1NAoqrKPdTGNBngNkjV%2F20250321%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250321T074255Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=8a316a9398f22723d11a828e2c832c7ef38fd9090c8a6e651ded6bf67e03a623"
            )!
        ),
    ]
}
