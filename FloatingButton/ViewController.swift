//
//  ViewController.swift
//  FloatingButton
//
//  Created by 김도희 on 2021/07/12.
//

import UIKit

class ViewController: UIViewController {

    private var floatingButton: FloatingActionButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(view.safeAreaInsets.bottom)
        floatingButton = FloatingActionButton(frame: CGRect(
            x: view.frame.size.width - 60 - 15, // view.width - button width - little margin
            y: view.frame.size.height - 60 - view.safeAreaInsets.bottom, // view.height - button height - safeArea.bottom
            width: 60,
            height: 60
        ), baseColor: .cyan, accentColor: .systemPink) { button in
            let alert = UIAlertController(title: "Add Something", message: "Floating Button Tapped", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self.present(alert, animated: true)
        }
        view.addSubview(floatingButton)
    }

}

