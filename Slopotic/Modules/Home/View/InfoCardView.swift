//
//  InfoCardView.swift
//  Slopotic
//
//  Created by Mac on 2022/5/15.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import SnapKit
import UIKit

class InfoCardView: UIView {
    lazy var contentView = UIView()
    lazy var image: UIImageView = .init()
    lazy var labelView = UIView()
    lazy var title = UILabel()
    lazy var content = UILabel()
    lazy var button = UIButton()

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
        contentView.addSubview(image)
        contentView.addSubview(labelView)
        image.addSubview(button)
        labelView.addSubview(title)
        labelView.addSubview(content)
       
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.8
        
        image.image = UIImage(named: "info")
        image.backgroundColor = UIColor(red: 0.98, green: 1.00, blue: 1.00, alpha: 1.00)
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true

        button.setTitle("Details >", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 10

        title.font = .systemFont(ofSize: 40, weight: .semibold)
        title.textColor = .black
        title.text = "Slopotic"
        
        content.font = .systemFont(ofSize: 20, weight: .regular)
        content.textColor = UIColor(red: 0.07, green: 0.13, blue: 0.48, alpha: 1.00)
        content.text = "Help you to relive insomnia with Music and building better Bedtime Routine"
        content.numberOfLines = 3
        content.lineBreakMode = NSLineBreakMode.byWordWrapping

        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(red: 0.76, green: 0.89, blue: 1.00, alpha: 1.00)
    }
    
    func layout() {
        image.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.top.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(30)
        }
        
        labelView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(image.snp.bottom).offset(10)
        }

        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
        }
        
        content.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(title.snp.bottom).offset(5)
        }
        
        contentView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}
