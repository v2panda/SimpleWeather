
'use strict';

import Storage from 'react-native-storage';

global.storage = new Storage({
  size: 1000,
  defaultExpires: null
});
