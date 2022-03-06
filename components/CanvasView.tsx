import {
  HostComponent,
  requireNativeComponent,
  StyleProp,
  ViewStyle,
} from 'react-native';

export interface CanvasViewProps {
  style?: StyleProp<ViewStyle> | undefined;
}

// requireNativeComponent automatically resolves 'RNTCanvas' to 'RNTCanvasManager'
const CanvasView: HostComponent<CanvasViewProps> =
  requireNativeComponent('RNTCanvas');

export default CanvasView;
