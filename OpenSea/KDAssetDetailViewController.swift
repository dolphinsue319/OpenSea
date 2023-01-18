//
//  KDAssetDetailViewController.swift
//  OpenSea
//
//  Created by Kedia on 2023/1/18.
//

import Foundation
import UIKit

class KDAssetDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(linkButton)

        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.8).isActive = true

        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true

        linkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        linkButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        linkButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        linkButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        self.title = viewModel?.collectionName
        self.imageView.sd_setImage(with: URL(string: viewModel?.imageURLString ?? ""))
        self.nameLabel.text = viewModel?.assetName
        self.descriptionLabel.text = viewModel?.description
    }

    init(viewModel: KDAssetDetailViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Privates

    private var viewModel: KDAssetDetailViewControllerViewModel?
    private lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = .systemFont(ofSize: 16, weight: .bold)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var descriptionLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = .systemFont(ofSize: 14)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var linkButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle("More details", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(linkButtonMethod(_ :)), for: .touchUpInside)
        return b
    }()

    @objc private func linkButtonMethod(_ sender: UIButton) {
        guard let linkString = viewModel?.permalinkString, let url = URL(string: linkString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
