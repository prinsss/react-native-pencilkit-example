import {atom} from 'recoil';
import {Drawing} from './types';

export const drawingsListState = atom<Drawing[]>({
  key: 'drawingsList',
  default: [],
});
