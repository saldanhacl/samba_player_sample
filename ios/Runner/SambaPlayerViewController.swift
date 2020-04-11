//
//  ViewController.swift
//  SambaPlayerSample
//
//  Created by Lucas Saldanha on 10/04/20.
//  Copyright © 2020 Lucas Saldanha. All rights reserved.
//

import UIKit
import SambaPlayer

class SambaPlayerViewController: UIViewController, SambaPlayerDelegate {
    
    var sambaPlayer: SambaPlayer?
    var delegate: GoBackDelegate?
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let projectHash = ""
    let mediaId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.startAnimating()
        setupPlayer()
    }
    
    
    private func setupPlayer() {
        self.sambaPlayer = SambaPlayer(parentViewController: self, andParentView: playerView)
        
        self.requestMedia()
    }
    
    private func requestMedia() {
        SambaApi().requestMedia(SambaMediaRequest(projectHash: projectHash, mediaId: mediaId)) { media in
            
            guard let media = media as? SambaMediaConfig, let player = self.sambaPlayer else {
                return
            }
            
            player.delegate = self
            player.media = media
            
            player.play()
        }
    }
    
    func onLoad() {
        loadingIndicator.stopAnimating()
        setFullScreen()
    }
    
    private func setFullScreen() {
        guard let player = self.sambaPlayer else {
            return
        }
        
        playerView.isHidden = false
        player.fullscreen = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        if UIDevice.current.orientation.isPortrait {
            delegate?.goBack()
        }
    }
}

