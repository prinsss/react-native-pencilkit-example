# react-native-pencilkit-example

A Proof-Of-Concept for using Apple [PencilKit](https://developer.apple.com/documentation/pencilkit) in React Native.

## Installation

To try it out, clone the repo and run:

```bash
yarn
npx pod-install ios
yarn ios
```

## Notes

I'm completely new to iOS development, so there's no guarantee on the stability of the solution.

What works now:

- Creating `PKCanvasView` with native component `<CanvasView />`
- Show a `PKToolPicker`
- Draw on canvas with fingers or Apple pencil
- Get & set `PKDrawing` data via base64 encoded string
- Clear canvas

## License

MIT
