

import 'package:firebase_database/firebase_database.dart';

class DatabaseHandler
{
    final database = FirebaseDatabase.instance.ref();

    void data_write(String key, Map<String,String> values)
    {
      final instance = database.child(key);
      instance.set(values);
    }
    void data_update(String key, Map<String,String> values)
    {
      final instance = database.child(key);
      instance.update(values);
    }
    Future data_read(String key) async
    {
      final value = await database.child(key).get();
      if(value.exists)
      {
        return value.value.toString();
      }
      else
      {
        return 'No record has been founded under this key';
      }
    }
}