(mapped, arg) ->
  opts      = eval(arg)
  sort_fun  = (a, b) ->
    return  if opts.order == 'asc'
              a[opts.sort_key] - b[opts.sort_key]
            else
              b[opts.sort_key] - a[opts.sort_key]

  return mapped.sort(sort_fun);
