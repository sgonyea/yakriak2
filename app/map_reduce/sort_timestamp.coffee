(values) ->
  return Riak.filterNotFound(values).
    sort((a, b) ->
      return a.timestamp - b.timestamp)