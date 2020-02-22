//
//  iCarousel+ViewLoading.swift
//  iCarouselSwift
//
//  Created by 郑军铎 on 2020/2/22.
//  Copyright © 2020 郑军铎. All rights reserved.
//

import Foundation
import UIKit

extension iCarousel {
    @discardableResult
    func loadView(at index: Int, withContainerView containerView: UIView? = nil) -> UIView {
        transactionAnimated(false) {
            let view: UIView = createView(at: index)
            setItemView(view, forIndex: index)
            if let containerView = containerView {
                if let oldItemView = containerView.subviews.last {
                    queue(oldItemView, at: index)
                    oldItemView.removeFromSuperview()
                }
                //set container frame
                if isVertical {
                    containerView.bounds.size.width = view.frame.size.width;
                    containerView.bounds.size.height = min(itemWidth, view.frame.size.height);
                } else {
                    containerView.bounds.size.width = min(itemWidth, view.frame.size.width);
                    containerView.bounds.size.height = view.frame.size.height;
                }
                //set view frame
                view.frame.origin.x = (containerView.bounds.size.width - view.frame.size.width) / 2.0
                view.frame.origin.y = (containerView.bounds.size.height - view.frame.size.height) / 2.0
                containerView.addSubview(view)
            } else {
                contentView.addSubview(self.containView(view))
            }
            view.superview?.layer.opacity = 0.0
            transformItemView(view, at: index)
            return view
        }
    }
    func loadUnloadViews() {
        updateItemWidth()
        updateNumberOfVisibleItems()
        var visibleIndices = Set<Int>()
        let minV = -Int(ceil(CGFloat(state.numberOfPlaceholdersToShow) / 2.0))
        let maxV = numberOfItems - 1 + state.numberOfPlaceholdersToShow / 2
        var offset = self.currentItemIndex - numberOfVisibleItems / 2;
        if isWrapEnabled {
            offset = max(minV, min(maxV - numberOfVisibleItems + 1, offset))
        }
        (0..<numberOfVisibleItems).forEach { (i) in
            var index = i + offset
            if isWrapEnabled {
                index = clamped(index: index)
            }
            let alpha = animator.alphaForItem(with: offsetForItem(at: index))
            if alpha > 0 {
                visibleIndices.insert(index)
            }
        }
        itemViews.forEach { (number, view) in
            guard !visibleIndices.contains(number) else {
                return
            }
            queue(view, at: number)
            view.superview?.removeFromSuperview()
            itemViews[number] = nil
        }
        visibleIndices.forEach { (number) in
            if itemViews[number] == nil {
                loadView(at: number)
            }
        }
    }
    func reloadData() {
        //remove old views
        itemViews.values.forEach { (view) in
            view.superview?.removeFromSuperview()
        }
        //bail out if not set up yet
        guard let dataSource = dataSource else {
            return
        }
        //get number of items and placeholders
        numberOfVisibleItems = 0
        numberOfItems = dataSource.numberOfItems(in: self)
        numberOfPlaceholders = dataSource.numberOfPlaceholders(in: self)
        //reset view pools
        self.itemViews = [:]
        self.itemViewPool = []
        self.placeholderViewPool = []
        //layout views
        self.setNeedsLayout()
        //fix scroll offset
        if numberOfItems > 0 && scrollOffset < 0.0 {
            scrollToItem(at: 0, animated: numberOfPlaceholders > 0)
        }
    }
}
extension iCarousel {
    private func createView(at index: Int) -> UIView {
        let view: UIView?
        if index < 0 {
            let index = Int(ceil(CGFloat(state.numberOfPlaceholdersToShow) / 2.0)) + index
            view = dataSource?.carousel(self, placeholderViewAt: index, reusingView: self.dequeuePlaceholderView())
        } else if index >= numberOfItems {
            let index = Int(CGFloat(state.numberOfPlaceholdersToShow) / 2.0) + index - numberOfItems
            view = dataSource?.carousel(self, placeholderViewAt: index, reusingView: self.dequeuePlaceholderView())
        } else {
            view = dataSource?.carousel(self, viewForItemAt: index, reusingView: self.dequeueItemView())
        }
        return view ?? UIView()
    }
}
