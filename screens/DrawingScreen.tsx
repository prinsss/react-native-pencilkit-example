import React, {useCallback, useLayoutEffect} from 'react';
import {Button, StyleSheet, Text, View} from 'react-native';
import {RootStackScreenProps} from '../types';

export default function DrawingScreen({
  navigation,
  route,
}: RootStackScreenProps<'Drawing'>) {
  const {id} = route.params;

  const saveDrawing = useCallback(() => {
    navigation.goBack();
  }, [navigation]);

  useLayoutEffect(() => {
    navigation.setOptions({
      headerRight: () => <Button title="Save" onPress={saveDrawing} />,
    });
  }, [navigation, saveDrawing]);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Draw! {id}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
  },
});
