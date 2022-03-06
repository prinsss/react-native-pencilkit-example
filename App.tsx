import React from 'react';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {StatusBar} from 'react-native';
import {SafeAreaProvider} from 'react-native-safe-area-context';
import {NavigationContainer} from '@react-navigation/native';
import {RootStackParamList} from './types';
import HomeScreen from './screens/HomeScreen';
import DrawingScreen from './screens/DrawingScreen';
import {useUIColor} from 'swiftui-react-native';
import {RecoilRoot} from 'recoil';

const Stack = createNativeStackNavigator<RootStackParamList>();

export default function App() {
  const UIColor = useUIColor();

  return (
    <RecoilRoot>
      <SafeAreaProvider>
        <StatusBar />
        <NavigationContainer>
          <Stack.Navigator initialRouteName="Home">
            <Stack.Screen
              name="Home"
              component={HomeScreen}
              options={{
                headerLargeTitle: true,
                headerLargeStyle: {
                  backgroundColor: UIColor.systemGray6,
                },
                // headerTransparent: true,
                // headerBlurEffect: 'regular',
                headerLargeTitleShadowVisible: false,
                // headerSearchBarOptions: {
                //   onChangeText: event => setSearch(event.nativeEvent.text),
                // },
              }}
            />
            <Stack.Screen name="Drawing" component={DrawingScreen} />
          </Stack.Navigator>
        </NavigationContainer>
      </SafeAreaProvider>
    </RecoilRoot>
  );
}
