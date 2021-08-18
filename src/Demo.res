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

type digit = [#"1" | #"2" | #"3" | #"4" | #"5" | #"6" | #"7" | #"8" | #"9" | #"10"]
type tokenStruct = { tokenType: tokenType, text: int }

let handleInitial = ch => {
  switch ch {
    | #...digit => { tokenType: IntLitera, text: ch}
    // | ">" => { tokenType: GE, text: ch }
    | _ => { tokenType: ID, text: ch }
  }
}

// let handleInitial = ch => {
// }

// let parse = (input: string) => {
//   let len = String.length(input)
//   let curIndex = ref(0)
//   let curState = ref(Initial)
//   let curToken = ref()
//   while curIndex.contents < len {
//     let ch = String.make(1, String.get(input, curIndex.contents))
//     let (state, token) = switch curState.contents {
//       | Initial => handleInitial(ch)
//     }
//     curState := state
//     curToken := token
//     curIndex := curIndex.contents + 1
//   }
// }