//
//  PlayViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 30/3/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import SnapKit
import UIKit

class PlayViewController: UIViewController {
    let data = [
        PlaylistModel(image: UIImage(named: "white_noise")!, title: "White Noise", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DWUZ5bk6qqDSy?si=546b9159e0bf409e")!),
        PlaylistModel(image: UIImage(named: "dreamy_vibes")!, title: "Dreamy Vibes", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DWSiZVO2J6WeI?si=c2f823209b2d4b11")!),
        PlaylistModel(image: UIImage(named: "birds_in_the_rain")!, title: "Birds in The Rain", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DX0eAsdXwbE4f?si=b9cce2a518344d1a")!),
        PlaylistModel(image: UIImage(named: "day_dreamer")!, title: "Day Dreamer", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DXdbkmlag2h7b?si=77f838d9874e4e30")!),
        PlaylistModel(image: UIImage(named: "the_moon_is_calling")!, title: "The Moon is Calling", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DWWxd0qWj50iH?si=3e8a2dbaffb84edd")!),
        PlaylistModel(image: UIImage(named: "lullabies")!, title: "Lullabies", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DX9QSrZ8cQbyd?si=935e22df9c094b69")!),
        PlaylistModel(image: UIImage(named: "pink_noise")!, title: "Pink Noise", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DWZhzMp90Opmn?si=1e9f10bd08d946a9")!),
        PlaylistModel(image: UIImage(named: "jazz_for_sleep")!, title: "Jazz for Sleep", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DXa1rZf8gLhyz?si=bfbeffec265d4a96")!),
        PlaylistModel(image: UIImage(named: "binaural_beats")!, title: "Binaural Beats", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DX8h3zQNo57xG?si=a8d5b57ca9bd4e53")!),
        PlaylistModel(image: UIImage(named: "peaceful_piano")!, title: "Peaceful Piano", url: URL(string: "https://open.spotify.com/playlist/37i9dQZF1DX4sWSpwq3LiO?si=009912e60220459b")!)
    ]

    lazy var contentView = PlayView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Play"
        navigationController?.navigationBar.prefersLargeTitles = true

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
        let isSpotifyInstalled = UIApplication.shared.canOpenURL(URL(string: "spotify:")!)
        guard isSpotifyInstalled else {
            let alert = UIAlertController(title: "Spotify Not Installed", message: "You haven't installed Spotify in this device.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Install Now", style: .default, handler: { _ in
                UIApplication.shared.open(URL(string: "https://itunes.apple.com/app/spotify-music/id324684580?mt=8")!)
            }))
            alert.addAction(UIAlertAction(title: "Later", style: .default))
            present(alert, animated: true)
            return
        }
        UIApplication.shared.open(data[indexPath.row].url)
    }
}
