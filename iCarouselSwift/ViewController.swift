//
//  ViewController.swift
//  iCarouselSwift
//
//  Created by 郑军铎 on 2020/2/22.
//  Copyright © 2020 郑军铎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var carousel: iCarousel!
    var dataSource: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = (0...10).map(String.init)
        carousel.animator = iCarousel.Animator.Linear().wrapEnabled(true)
        carousel.delegate = self
        carousel.dataSource = self
        carousel.isPagingEnabled = true
//        carousel.autoscroll = -1
    }

    @IBAction func deleteItem(_ sender: UIBarButtonItem) {
        if self.carousel.numberOfItems > 0 {
            let index = self.carousel.currentItemIndex
            self.dataSource.remove(at: index)
            self.carousel.removeItem(at: index, animated: true)
        }
    }
    @IBAction func insertItem(_ sender: UIBarButtonItem) {
        let index = max(0, self.carousel.currentItemIndex)
        self.dataSource.insert("\(self.carousel.numberOfItems)", at: index)
        self.carousel.insertItem(at: index, animated: true)
    }
}

extension ViewController: iCarouselDelegate {
    
}
extension ViewController: iCarouselDataSource {
    func numberOfPlaceholders(in carousel: iCarousel) -> Int {
        4
    }
    func carousel(_ carousel: iCarousel, placeholderViewAt index: Int, reusingView: UIView?) -> UIView? {
        let reusingView: UIImageView = reusingView as? UIImageView ?? {
            let imageView = UIImageView(image: UIImage(named: "page"))
            imageView.contentMode = .scaleAspectFill
            let label = UILabel()
            label.tag = 1
            imageView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
            return imageView
        }()
        let label = reusingView.viewWithTag(1) as? UILabel
        label?.text = "加载中"
        return reusingView
    }
    func numberOfItems(in carousel: iCarousel) -> Int {
        dataSource.count
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusingView: UIView?) -> UIView {
        let reusingView: UIImageView = reusingView as? UIImageView ?? {
            let imageView = UIImageView(image: UIImage(named: "page"))
            imageView.contentMode = .scaleAspectFill
            let label = UILabel()
            label.tag = 1
            imageView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
            return imageView
        }()
        let label = reusingView.viewWithTag(1) as? UILabel
        label?.text = dataSource[index]
        return reusingView
    }
    
}
