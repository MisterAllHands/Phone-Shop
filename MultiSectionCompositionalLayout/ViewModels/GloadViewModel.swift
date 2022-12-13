//////
//////  GloabalModalView.swift
//////  MultiSectionCompositionalLayout
//////
//////  Created by TTGMOTSF on 11/12/2022.
//////
////
////import Foundation
////import UIKit
////
////
//func infinateLoop(scrollView: UIScrollView) {
//    var index = Int((scrollView.contentOffset.x)/(scrollView.frame.width))
//    guard currentIndex != index else {
//        return
//    }
//    currentIndex = index
//    if index <= 0 {
//        index = images.count - 1
//        scrollView.setContentOffset(CGPoint(x: (scrollView.frame.width+60) * CGFloat(images.count), y: 0), animated: false)
//    } else if index >= images.count + 1 {
//        index = 0
//        scrollView.setContentOffset(CGPoint(x: (scrollView.frame.width), y: 0), animated: false)
//    } else {
//        index -= 1
//    }
//    pageController.currentPage = index
//}
//
//func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//    infinateLoop(scrollView: scrollView)
//}
//func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    infinateLoop(scrollView: scrollView)
//}
