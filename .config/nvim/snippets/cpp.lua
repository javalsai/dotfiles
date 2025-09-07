-- this is intended for header files anyways
return {
  s('#include-guard', fmt([[
#ifndef {guard}
#define {guard}

{body}

#endif /* {guard} */
]], {
    guard = i(1, "HEADER_H"),
    body  = i(0),
  }, {
    repeat_duplicates = true, -- key option in `fmt`
  })
  ),
}
