//
//  PopUpVC.swift
//  ExpenseTracker
//
//  Created by Ebuzer Şimşek on 17.07.2023.
//

import UIKit

class PopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Yarım sayfa görünümünün boyutunu ve stilini ayarlayın
        configureAppearance()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Yarım sayfa açılırken veya kapanırken animasyon ve geçiş efektlerini uygulayın
        applyTransitionAnimations()
    }

    // Yarım sayfa görünümünün boyutunu ve stilini ayarlayan fonksiyon
    private func configureAppearance() {
        let halfPageWidth = view.bounds.width / 2
        let halfPageHeight = view.bounds.height
        view.frame = CGRect(x: 0, y: 0, width: halfPageWidth, height: halfPageHeight)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
    }

    // Yarım sayfa açılırken veya kapanırken animasyon ve geçiş efektlerini uygulayan fonksiyon
    private func applyTransitionAnimations() {
        view.transform = CGAffineTransform(translationX: view.bounds.width / 2, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
    }
}
