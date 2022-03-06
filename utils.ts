import uuid from 'react-native-uuid';

export function generateRandomUUID() {
  return uuid.v4() as string;
}
