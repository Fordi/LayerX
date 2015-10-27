//
//  ViewController.swift
//  LayerX
//
//  Created by Michael Chen on 2015/10/26.
//  Copyright © 2015年 Michael Chen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet weak var imageView: MCDragAndDropImageView!
	@IBOutlet weak var sizeTextField: NSTextField!
	@IBOutlet weak var placeholderTextField: NSTextField!

	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		imageView.delegate = self

		sizeTextField.layer?.cornerRadius = 3
		sizeTextField.layer?.masksToBounds = true

		NSNotificationCenter.defaultCenter().addObserver(self, selector: "windowDidResize:", name: NSWindowDidResizeNotification, object: appDelegate().window)
	}

	func windowDidResize(notification: NSNotification) {
		let window = notification.object as! NSWindow
		let size = window.frame.size
		sizeTextField.stringValue = "\(Int(size.width))x\(Int(size.height))"
	}
}

// MARK: - MCDragAndDropImageViewDelegate

extension ViewController: MCDragAndDropImageViewDelegate {
	func dragAndDropImageViewDidDrop(imageView: MCDragAndDropImageView) {
		guard let image = imageView.image, let window = appDelegate().window else { return }

		sizeTextField.hidden = false
		placeholderTextField.hidden = true
		window.resizeTo(image.size, animated: true)
	}
}

// MARK: - Movable NSView

class MCMovableView: NSView{
	override var mouseDownCanMoveWindow:Bool {
		return true
	}
}