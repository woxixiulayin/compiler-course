let reExec = (reStr, str) => Js.Re.fromString(reStr) -> Js.Re.exec_(str)
let isDigit = ch => reExec("[0-9]", ch)
let isAlpha = ch => reExec("[a-zA-Z]", ch)

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

// let parse = input => {
//   let current = 0
//   let state = Initial
//   while current < input.length {
//     let ch = input[current]
//     state = switch state {
//     | Initial => expression
//     | ID => expression
//     }
//     current++
//   }
// }

// let handleInitial = (ch) => {
//   if isDigit(ch) {
    
//   }
// }