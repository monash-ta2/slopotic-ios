//
//  PlayerView.swift
//  Slopotic
//
//  Created by Weiyi Kong on 4/5/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    lazy var artwork = UIImageView()
    lazy var title = UILabel()
    lazy var subtitle = UILabel()
    lazy var playButton = UIImageView(image: UIImage(systemName: "stop.fill"))
    lazy var nextButton = UIImageView(image: UIImage(systemName: "forward.fill"))

    lazy var status: AVPlayer.TimeControlStatus = .waitingToPlayAtSpecifiedRate {
        didSet {
            title.textColor = .label
            playButton.image = UIImage(systemName: (status == .playing ? "pause.fill" : "play.fill"))
            playButton.tintColor = .label
            nextButton.tintColor = .label
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        backgroundColor = .systemGray4

        artwork.layer.cornerRadius = 8
        artwork.clipsToBounds = true
        artwork.contentMode = .scaleAspectFill
        addSubview(artwork)

        title.text = "Not Playing"
        title.font = .systemFont(ofSize: 16, weight: .regular)
        title.textColor = .systemGray2
        addSubview(title)

        playButton.tintColor = .systemGray2
        playButton.isUserInteractionEnabled = true
        addSubview(playButton)

        nextButton.tintColor = .systemGray2
        nextButton.isUserInteractionEnabled = true
        addSubview(nextButton)
    }

    func layout() {
        artwork.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(artwork.snp.height)
            make.left.equalToSuperview().offset(16)
        }

        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(artwork.snp.right).offset(16)
            make.right.lessThanOrEqualTo(playButton.snp.left).offset(-16)
        }

        playButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(nextButton.snp.left).offset(-16)
            make.height.width.equalTo(32)
        }

        nextButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(32)
        }
    }
}
