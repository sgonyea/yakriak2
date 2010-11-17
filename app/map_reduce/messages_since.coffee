(object, key_data, arg) ->
  values = Riak.mapvaluesJson(object)[0]
  if values.timestamp >= arg
    [value]
  else
    []