//
//  ViewController.swift
//  FloatingButton
//
//  Created by 김도희 on 2021/07/12.
//

import UIKit

class ViewController: UIViewController {

    private let floatingButton: UIButton = {
        let button = UIButton(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 60,
                height: 60
            ))
        // Icon
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        // Colors
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        // Shadow
        button.layer.shadowOpacity = 0.3
        button.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 5,
                width: 60 + 5,
                height: 60
            ),
            cornerRadius: 30
        ).cgPath
        button.layer.shouldRasterize = true // cache the rendered shadow
        // Corner radius
        button.layer.cornerRadius = 30
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapFAB), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(
            x: view.frame.size.width - 60 - 15, // view.width - button width - little margin
            y: view.frame.size.height - 60 - view.safeAreaInsets.bottom, // view.height - button height - safeArea.bottom
            width: 60,
            height: 60
        )
    }

    @objc
    private func didTapFAB() {
        let alert = UIAlertController(title: "Add Something", message: "Floating Button Tapped", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}

