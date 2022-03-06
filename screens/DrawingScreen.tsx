import React, {useCallback, useLayoutEffect} from 'react';
import {Alert, Button, NativeModules, StyleSheet} from 'react-native';
import {useRecoilState} from 'recoil';
import CanvasView from '../components/CanvasView';
import {drawingsListState} from '../store';
import {RootStackScreenProps} from '../types';

export default function DrawingScreen({
  navigation,
  route,
}: RootStackScreenProps<'Drawing'>) {
  const {id} = route.params;
  const {RNTCanvasManager} = NativeModules;
  const [drawings, setDrawings] = useRecoilState(drawingsListState);

  const saveCanvas = useCallback(async () => {
    try {
      const data = await RNTCanvasManager.getDrawingData();
      // console.log(data);
      setDrawings(
        drawings.map(drawing =>
          drawing.id === id
            ? {
                ...drawing,
                data,
              }
            : drawing,
        ),
      );
      navigation.goBack();
    } catch (err) {
      Alert.alert('Failed to Save', (err as Error).message);
      console.error(err);
    }
  }, [RNTCanvasManager, drawings, id, navigation, setDrawings]);

  const setDrawingData = useCallback(
    async (base64EncodedData: string) => {
      try {
        await RNTCanvasManager.setDrawingData(base64EncodedData);
      } catch (err) {
        Alert.alert('Failed to Init', (err as Error).message);
        console.error(err);
      }
    },
    [RNTCanvasManager],
  );

  useLayoutEffect(() => {
    navigation.setOptions({
      headerRight: () => (
        <>
          <Button title="Clear" onPress={() => setDrawingData('')} />
          <Button title="Save" onPress={saveCanvas} />
        </>
      ),
    });
    setDrawingData(drawings.filter(it => it.id === id)?.[0]?.data);
  }, [drawings, id, navigation, saveCanvas, setDrawingData]);

  return <CanvasView style={styles.canvas} />;
}

const styles = StyleSheet.create({
  canvas: {
    flex: 1,
  },
});
