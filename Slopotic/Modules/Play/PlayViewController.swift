//
//  PlayViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 30/3/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import SnapKit
import UIKit
import Alamofire

class PlayViewController: UIViewController {
    lazy var dataURL = URL(string: "https://data.slopotic.tech/playlist.json")!
    lazy var data = [Playlist]() {
        didSet {
            contentView.collectionView.reloadData()
        }
    }

    lazy var contentView = PlayView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Play"
        navigationController?.navigationBar.prefersLargeTitles = true

        AF.request(dataURL).responseDecodable(of: [Playlist].self) { [weak self] response in
            do {
                try self?.data = response.result.get()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }

        configUI()
    }

    func configUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        configCollectionView()
    }

    func configCollectionView() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.collectionView.register(PlayCardView.self, forCellWithReuseIdentifier: "playCard")
    }
}

extension PlayViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playCard", for: indexPath) as! PlayCardView
        cell.update(data[indexPath.row])
        cell.invalidateIntrinsicContentSize()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.size.width, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
