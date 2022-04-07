//
//  HomeViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 30/3/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        initialSetup()
    }

    func initialSetup() {
        if UserDefaults.standard.bool(forKey: "didSetup") { return }
        if !UserDefaults.standard.bool(forKey: "didAgree") { agreementConfirm() } else { supplementConfirm() }
    }

    func agreementConfirm() {
        let disclaimer = UIAlertController(title: "Disclaimer", message: "This app provides only information, is not medical or treatment advice. The information on this app is not a substitute for professional medical advice, diagnosis or treatment. If you have any specific questions about any medical matter you should consult your physician or other professional healthcare provider. If you think you may be suffering from any medical condition you should seek immediate medical attention.", preferredStyle: .alert)
        disclaimer.addAction(UIAlertAction(title: "Agree", style: .cancel, handler: { [weak self] _ in
            self?.supplementConfirm()
            DBManager.shared.setupSleep()
            UserDefaults.standard.set(true, forKey: "didAgree")
        }))
        disclaimer.addAction(UIAlertAction(title: "Disagree", style: .default, handler: { _ in
            exit(0)
        }))
        present(disclaimer, animated: true)
    }

    func supplementConfirm() {
        let supplementConfirm = UIAlertController(title: "Confirmation", message: "Are you taking any sleeping supplements without prescriptions or advices from your GP?", preferredStyle: .alert)
        supplementConfirm.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: { _ in
            UserDefaults.standard.set(true, forKey: "enableSupplement")
            UserDefaults.standard.set(true, forKey: "didSetup")
        }))
        supplementConfirm.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
            UserDefaults.standard.set(false, forKey: "enableSupplement")
            UserDefaults.standard.set(true, forKey: "didSetup")
        }))
        present(supplementConfirm, animated: true)
    }
}
