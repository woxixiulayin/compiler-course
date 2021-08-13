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

let parse = input => {
  let current = 0
  let state = Initial
  while current < input.length {
    let ch = input[current]
    state = switch state {
    | Initial => expression
    | ID => expression
    }
    current++
  }
}

let handleInitial = (ch) => {
  if isDigit(ch) {
    
  }
}

let isDigit = ch => Js.Re.test_(/[0-9]/, ch)
let isAlpha = ch => Js.Re.test_(/[a-zA-Z], ch/)