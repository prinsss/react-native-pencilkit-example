import React from 'react';
import {ScrollView, StyleSheet} from 'react-native';
import {RootStackScreenProps} from '../types';
import {Text, Button, List, useUIColor, Image} from 'swiftui-react-native';
import {useRecoilState} from 'recoil';
import {drawingsListState} from '../store';
import {generateRandomUUID} from '../utils';

export default function HomeScreen({navigation}: RootStackScreenProps<'Home'>) {
  const UIColor = useUIColor();
  const [drawings, setDrawings] = useRecoilState(drawingsListState);

  const addCanvas = () =>
    setDrawings([
      ...drawings,
      {
        id: generateRandomUUID(),
        name: 'New canvas',
        data: '',
      },
    ]);

  return (
    <ScrollView
      contentInsetAdjustmentBehavior="automatic"
      style={[styles.container, {backgroundColor: UIColor.systemGray6}]}>
      <List inset>
        {drawings.map(drawing => (
          <Button
            action={() => navigation.navigate('Drawing', {id: drawing.id})}
            key={drawing.id}>
            <Text alignment="leading" foregroundColor={UIColor.label}>
              {drawing.name} {drawing.id.split('-')[0]}
            </Text>
          </Button>
        ))}
        <Button action={addCanvas} style={styles.iconButton}>
          <Image systemName="plus" fontSize={20} />
          <Text> Add Canvas</Text>
        </Button>
      </List>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {},
  iconButton: {
    flexDirection: 'row',
    justifyContent: 'flex-start',
    alignItems: 'center',
  },
});
