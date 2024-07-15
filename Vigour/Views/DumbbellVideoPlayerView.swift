//  DumbbellVideoPlayerView.swift
//  Vigour
//  Created by Melody Flavel on 3/7/2024.

import SwiftUI
import AVFoundation

// MARK: Dumbbell Video Player View
struct DumbbellVideoPlayerView: UIViewRepresentable {
    
    var videoName: String

    // MARK: Make UI View
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(videoName: videoName)
    }

    // MARK: UpdateUIView
    func updateUIView(_ uiView: UIView, context: Context) {
        // No update code.
    }
}

// MARK: Looping Player UI View
class LoopingPlayerUIView: UIView {
    
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?

    // MARK: Initialise
    init(videoName: String) {
        super.init(frame: .zero)
        
        guard let dataAsset = NSDataAsset(name: videoName) else {
            print("Video asset not found.")
            return
        }
        
        let tempFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(videoName + ".mov")
        
        do {
            try dataAsset.data.write(to: tempFileURL)
        } catch {
            print("Failed to write video data to temporary file: \(error)")
            return
        }
        
        let asset = AVAsset(url: tempFileURL)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer(playerItem: playerItem)
        
        playerLayer.player = player
        layer.addSublayer(playerLayer)

        let looper = AVPlayerLooper(player: player, templateItem: playerItem)
        self.playerLooper = looper

        player.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
