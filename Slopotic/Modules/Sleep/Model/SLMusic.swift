//
//  SLMusic.swift
//  Slopotic
//
//  Created by Weiyi Kong on 4/5/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import AVFoundation

class SLMusic: AVPlayerItem {
    var title: String?
    var subtitle: String?

    init(music model: Music) {
        super.init(asset: AVAsset(url: Playlist.baseURL.appendingPathComponent(model.url)), automaticallyLoadedAssetKeys: ["duration"])

        title = model.title
    }
}
