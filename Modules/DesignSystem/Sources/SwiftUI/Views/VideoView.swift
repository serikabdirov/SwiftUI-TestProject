//
//  VideoView.swift
//  DesignSystem
//
//  Created by Александр Болотов on 18.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import AVKit
import MediaPlayer
import Nuke
import NukeUI
import SwiftUI

public enum VideoViewContent {
    case video(URL, cover: URL?)
    case audio(audio: URL, cover: URL?, title: String)

    var mediaURL: URL {
        switch self {
        case let .video(url, _):
            url
        case let .audio(url, _, _):
            url
        }
    }

    var coverURL: URL? {
        switch self {
        case let .video(_, url):
            url
        case let .audio(_, url, _):
            url
        }
    }

    var isAudio: Bool {
        if case .audio = self {
            true
        } else {
            false
        }
    }

    var asset: AVAsset {
        AVAsset(url: mediaURL)
    }

    // Получение заголовка
    var title: String? {
        switch self {
        case .video:
            nil
        case let .audio(_, _, title):
            title
        }
    }
}

public struct VideoView: View {
    @ObservedObject
    var videoViewData: VideoViewData

    public init(videoViewData: VideoViewData) {
        self.videoViewData = videoViewData
    }

    public var body: some View {
        PlayerView(content: videoViewData.content, player: videoViewData.player)
            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
            .overlay {
                if videoViewData.isLoading {
                    ProgressView()
                        .tint(UIColor.Background.activityProgressBar.swiftUIColor)
                        .scaleEffect(x: 2, y: 2)
                } else if videoViewData.showPlayButton {
                    Button {
                        videoViewData.playButtonDidTap()
                    } label: {
                        ZStack {
                            Rectangle()
                                .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                                .foregroundColor(.clear)

                            RAsset.Icons56.playFill.swiftUIImage
                        }
                    }
                }
            }
            .overlay {
                if videoViewData.errorLoad {
                    errorView
                }
            }

            .clipShape(.rect(cornerRadius: DesignSystem.Corner.L))
    }

    @ViewBuilder
    var errorView: some View {
        VStack(spacing: DS.Gap.S) {
            RAsset.Icons24.mediaError.swiftUIImage
                .padding(.top, 24)
            Text(RStrings.Ls.Uikit.Player.Error.title)
                .multilineTextAlignment(.center)
                .font(UIFont.sub2SemiBold.swiftUIFont)
                .foregroundStyle(UIColor.Text.main.swiftUIColor)
                .padding(.horizontal, DS.Gap.L)
            Text(RStrings.Ls.Uikit.Player.Error.body)
                .multilineTextAlignment(.center)
                .font(UIFont.captionReg.swiftUIFont)
                .foregroundStyle(UIColor.Text.secondary.swiftUIColor)
                .padding(.horizontal, DS.Gap.L)
            Button {
                videoViewData.load()
            } label: {
                HStack(spacing: DS.Gap.XS) {
                    RAsset.Icons24.refresh.swiftUIImage
                        .renderingMode(.template)
                        .tint(UIColor.Icons.green.swiftUIColor)
                    Text(RStrings.Ls.Uikit.Player.Error.retry)
                        .multilineTextAlignment(.center)
                        .font(UIFont.sub2SemiBold.swiftUIFont)
                        .foregroundStyle(UIColor.Button.textGreen.swiftUIColor)
                }
            }
            .frame(height: 28)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(UIColor.Background.grey.swiftUIColor)
    }
}

public final class VideoViewData: ObservableObject {
    @Published
    var isLoading = false

    @Published
    var showPlayButton = false

    @Published
    var errorLoad = false

    let content: VideoViewContent
    let player = AVPlayer()

    public init(content: VideoViewContent) {
        self.content = content
        if content.isAudio {
            setupAudioSession()
        }
        load()
    }

    // MARK: - Fileprivate methods

    fileprivate func playButtonDidTap() {
        player.play()
        showPlayButton = false
    }

    fileprivate func load() {
        Task { @MainActor in
            isLoading = true
            await loadPlayerItem()
            isLoading = false
        }
    }

    // MARK: - Private methods

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default,
                options: [.mixWithOthers, .allowAirPlay, .allowBluetooth]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }

    private func loadPlayerItem() async {
        await MainActor.run {
            errorLoad = false
        }

        do {
            let _ = try await content.asset.load(.tracks, .duration)
        } catch {
            print("Ошибка загрузки видео/аудио: \(error.localizedDescription)")

            await MainActor.run {
                errorLoad = true
            }

            return
        }

        let item = await AVPlayerItem(asset: content.asset)

        if content.isAudio {
            await setupMetadata(for: item)
        }

        player.replaceCurrentItem(with: item)

        await MainActor.run {
            showPlayButton = true
        }
    }

    private func setupMetadata(for item: AVPlayerItem) async {
        if let title = content.title {
            await MainActor.run {
                let titleMetadata = AVMutableMetadataItem()
                titleMetadata.identifier = .commonIdentifierTitle
                titleMetadata.value = title as NSString
                item.externalMetadata.append(titleMetadata)
            }
        }

        if let coverURL = content.coverURL {
            let imageTask = ImagePipeline.shared.imageTask(with: coverURL)
            let image = try? await imageTask.image

            await MainActor.run {
                if let imageData = image?.pngData() as? NSData {
                    let artwork = AVMutableMetadataItem()
                    artwork.identifier = .commonIdentifierArtwork
                    artwork.value = imageData
                    artwork.dataType = kCMMetadataBaseDataType_PNG as String
                    item.externalMetadata.append(artwork)
                }
            }
        }
    }
}

private struct PlayerView: UIViewControllerRepresentable {
    let content: VideoViewContent
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.player?.actionAtItemEnd = .none
        controller.beginAppearanceTransition(true, animated: true)

        switch content {
        case .video:
            controller.updatesNowPlayingInfoCenter = false
            controller.allowsPictureInPicturePlayback = true

        case .audio:
            controller.updatesNowPlayingInfoCenter = true
            controller.allowsPictureInPicturePlayback = false
        }

        if let coverURL = content.coverURL {
            loadCover(coverURL: coverURL, controller: controller, player: player)
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}

    // FIXME: - грузим эту же картинку в VideoViewData, я пока не понял как нормально передать сюда.
    private func loadCover(coverURL: URL, controller: AVPlayerViewController, player: AVPlayer) {
        let coverImageView = UIImageView()
        coverImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.alpha = 0

        controller.contentOverlayView?.addSubview(coverImageView)

        Task {
            let imageTask = ImagePipeline.shared.imageTask(with: coverURL)
            if let image = try? await imageTask.image {
                coverImageView.image = image
                UIView.animate(withDuration: 0.3) {
                    coverImageView.alpha = 1
                }
            }
        }

        if case .video = content {
            let interval = CMTime(seconds: 0.1, preferredTimescale: 600)
            _ = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
                if player.rate > 0 {
                    UIView.animate(withDuration: 0.3, animations: {
                        coverImageView.alpha = 0
                    }, completion: { _ in
                        coverImageView.removeFromSuperview()
                    })
                }
            }
        }
    }
}
