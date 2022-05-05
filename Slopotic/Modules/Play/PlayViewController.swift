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
import ProgressHUD
import AVFoundation

class PlayViewController: UIViewController {
    lazy var dataURL = URL(string: "https://data.slopotic.tech/playlist.json")!
    lazy var data = [Playlist]() {
        didSet {
            contentView.collectionView.reloadData()
        }
    }

    @objc lazy var player = AVQueuePlayer()
    lazy var currentPlaylistIndex: Int? = nil
    lazy var currentPlaylist = [Music]() {
        didSet {
            let itemList = currentPlaylist.map { SLMusic(music: $0) }
            player.removeAllItems()
            for item in itemList { player.insert(item, after: nil) }
        }
    }
    var observers = [NSKeyValueObservation]()

    lazy var contentView = PlayView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Play"
        navigationController?.navigationBar.prefersLargeTitles = true

        fetchData()
        configUI()
        setupPlayer()
    }

    func fetchData() {
        AF.request(dataURL).responseDecodable(of: [Playlist].self) { [weak self] response in
            do {
                try self?.data = response.result.get()
            } catch {
                ProgressHUD.showFailed(error.localizedDescription, interaction: true)
            }
        }
    }

    func setupPlayer() {
        observers.append(observe(\.player.rate, options: [.new], changeHandler: { [weak self] object, change in
            self?.contentView.playerView.status = (change.newValue == 0 ? .paused : .playing)
        }))
        observers.append(observe(\.player.currentItem, options: [.new], changeHandler: { [weak self] object, change in
            if let item = change.newValue as? SLMusic {
                self?.contentView.playerView.title.text = item.title
            }
        }))

        contentView.playerView.playButton.onTap { [weak self] _ in
            switch self?.contentView.playerView.status {
            case .playing:
                self?.player.pause()
            default:
                self?.player.play()
            }
        }

        contentView.playerView.nextButton.onTap { [weak self] _ in
            self?.player.advanceToNextItem()
        }
    }

    func configUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }

        // config collectionView
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
        if indexPath.row == currentPlaylistIndex { return }

        contentView.playerView.artwork.kf.setImage(with: Playlist.baseURL.appendingPathComponent(data[indexPath.row].image))
        currentPlaylistIndex = indexPath.row
        currentPlaylist = data[indexPath.row].music.shuffled()
        player.play()
    }
}
