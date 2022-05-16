//
//  WelCardView.swift
//  Slopotic
//
//  Created by Mac on 2022/5/15.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import SnapKit
import UIKit

class WelCardView: UIView {
    lazy var contentView = UIView()
    lazy var image: UIImageView = .init()
    lazy var hi = UILabel()
    lazy var title = UILabel()
    lazy var time = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(contentView)

        image.image = UIImage(named: "cover")
        image.contentMode = .scaleAspectFill
        contentView.addSubview(image)

        hi.font = .systemFont(ofSize: 43, weight: .bold)
        hi.textColor = .white
        hi.text = "Hi,"
        contentView.addSubview(hi)

        title.font = .systemFont(ofSize: 43, weight: .bold)
        title.textColor = .white
        title.text = "Good Night!"
        contentView.addSubview(title)

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WelCardView.updateTime), userInfo: nil, repeats: true)
        time.font = .systemFont(ofSize: 20, weight: .medium)
        time.textColor = .white
        contentView.addSubview(time)

        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }

    @objc func updateTime() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " MMM d yyyy, h:mm a"
        let currentTime = dateFormatter.string(from: date)
        time.text = currentTime
    }

    func layout() {
        image.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }

        hi.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-110)
        }

        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(hi.snp.bottom)
        }

        time.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(title.snp.bottom).offset(10)
        }

        contentView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}
