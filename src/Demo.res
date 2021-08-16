let isDigit = ch => Js_re.test_(%re("/[0-9]/"), ch)
let isAlpha = ch => Js_re.test_(%re("/[a-zA-Z]/"), ch)

// token类型
type tokenType =
| Identity
| IntLitera
| GT
| GE

// 有限状态机状态
type state =
| Initial
| ID
| GT
| GE
| IntLitera

let currentTokenType = ref(Identity)
let currentTokenText = ref("")

let handleInitial = ch => {
    currentTokenText := ch
  if isAlpha(ch) {
    currentTokenType := Identity
    ID
  } else if isDigit(ch) {
    currentTokenType := IntLitera
    IntLitera
  } else if ch === ">" {
    currentTokenType := GE
    GE
  } else {
    ID
  }
}

// let handleInitial = ch => {

// }

let parse = (input: string) => {
  let current = ref(0)
  let state = ref(GT)
  let len = String.length(input)
  while current.contents < len {
    let ch = String.make(1, String.get(input, current.contents))
    state := switch state.contents {
    | Initial => handleInitial(ch)
    }
    current := current.contents + 1
  }
}