//
//  RNTCanvasManager.swift
//  Drawing
//
//  Created by Prin S. on 2022/3/6.
//

import UIKit
import PencilKit

@available(iOS 14.0, *)
@objc(RNTCanvasManager)
class RNTCanvasManager: RCTViewManager {

  let canvasView: PKCanvasView = {
    let view = PKCanvasView()
    view.drawingPolicy = .anyInput
    view.minimumZoomScale = 0.5
    view.maximumZoomScale = 3
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  let toolPicker = PKToolPicker()

  @objc
  func setDrawingData(_ base64: String,
                      resolver resolve: RCTPromiseResolveBlock,
                      rejecter reject: RCTPromiseRejectBlock) {
    print("setDrawingData", base64.count)

    if (base64 == "") {
      self.canvasView.drawing = PKDrawing()
      print("Canvas cleared")
      resolve(true)
      return
    }

    guard let dataDecoded = Data(base64Encoded: base64) else {
      reject("E_DECODING", "Error while decoding", nil);
      return
    }

    do {
      self.canvasView.drawing = try PKDrawing.init(data: dataDecoded)
      self.canvasView.zoomScale = 1
      print("New drawing loaded")
      resolve(true)
    } catch {
      reject("E_DRAWING_INIT", "Error while loading drawing object", nil);
    }
  }

  @objc
  func getDrawingData(_ resolve: RCTPromiseResolveBlock,
                      rejecter reject: RCTPromiseRejectBlock) {
    let data = canvasView.drawing.dataRepresentation()
    print("getDrawingData", data.count)
    resolve(data.base64EncodedString())
  }

  @objc
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  override func view() -> UIView! {
    print("CanvasView initializing")

    // TODO: undo and redo
    // TODO: accept data as props
    // if let drawing = try? PKDrawing(data: drawingData) {
    //   canvas.drawing = drawing
    // }

    canvasView.delegate = self
    toolPicker.addObserver(self)
    toolPicker.addObserver(canvasView)
    toolPicker.setVisible(true, forFirstResponder: canvasView)
    canvasView.becomeFirstResponder()

    return canvasView
  }
}

// MARK: Canvas View Delegate
@available(iOS 14.0, *)
extension RNTCanvasManager: PKCanvasViewDelegate, PKToolPickerObserver {

  func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
    print("canvasViewDrawingDidChange")
  }

  func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
    print("toolPickerSelectedToolDidChange")
  }

  func toolPickerIsRulerActiveDidChange(_ toolPicker: PKToolPicker) {
    print("toolPickerIsRulerActiveDidChange")
  }

  func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
    print("toolPickerVisibilityDidChange")
  }

  func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
    print("toolPickerFramesObscuredDidChange")
  }
}
