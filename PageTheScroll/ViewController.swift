//
//  ViewController.swift
//  PageTheScroll
//
//  Created by Mikko Hilpinen on 31.8.2016.
//  Copyright © 2016 Mikko Hilpinen. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
	@IBOutlet weak var scrollView: UIScrollView!
	
	var images = [UIImageView]() // Not actually used here but usually useful
	
	// Scroll view frame data not available at this time
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		// Adds swipe gesture recognision
		let directions: [UISwipeGestureRecognizerDirection] = [.right, .left]
		for direction in directions
		{
			let gesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipe(sender:)))
			gesture.direction = direction
			self.view.addGestureRecognizer(gesture)
		}
	}
	
	// Frame data is available here
	override func viewDidAppear(_ animated: Bool)
	{
		// Keeps track of accumulated content width
		var contentWidth: CGFloat = 0
		
		// Adds the images into the image array and scroll view
		let scrollViewWidth = scrollView.frame.size.width
		for index in 0...2
		{
			let image = UIImage(named: "icon\(index)")
			let imageView = UIImageView(image: image)
			images.append(imageView)
			
			// repositions the image
			var x: CGFloat = 0.0
			x = scrollViewWidth / 2 + scrollViewWidth * CGFloat(index)
			
			scrollView.addSubview(imageView)
			// Frame is set after adding to view to make sure coordinate systems are correct
			imageView.frame = CGRect(x: x - 150 / 2, y: scrollView.frame.height / 2 - 150 / 2, width: 150, height: 150)
			
			contentWidth += scrollViewWidth // Was x in the example
		}
		
		scrollView.clipsToBounds = false // Shows content outside scrollview bounds
		scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height)
		
		//scrollView.contentOffset = CGPoint(x: scrollViewWidth, y: 0)
	}
	
	func handleSwipe(sender: UISwipeGestureRecognizer)
	{
		// Scrolls the scrollView when a swipe is recognised
		let scrollViewWidth = scrollView.frame.size.width
		let transition = sender.direction == .right ? -scrollViewWidth : scrollViewWidth
		
		let originalPosition = scrollView.contentOffset
		let newFrame = CGRect(origin: CGPoint(x: originalPosition.x + transition, y: originalPosition.y), size: scrollView.frame.size)
		
		// TODO: Doesn't bounce on the edges yet
		scrollView.scrollRectToVisible(newFrame, animated: true)
	}
}

