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

// token对象
type itoken = { tokenType: tokenType, text: string }

// 处理初始状态
let handleInitial = (ch, _) => {
  switch ch {
    | _ if isDigit(ch) => (IntLitera, { tokenType: IntLitera, text: ch})
    | ">" => (GT, { tokenType: GT, text: ch })
    | _ => (ID, { tokenType: Identity, text: ch })
  }
}

// 处理ID状态
let handleId = (ch, token: itoken) => {
  switch ch {
  | " " => (Initial, token)
  | _ => (ID, { tokenType: Identity, text: token.text ++ ch })
  }
}


let handleGT = (ch, token: itoken) => {
  switch ch {
  | " " => (Initial, token)
  | "=" => (GE, { tokenType: GE, text: token.text ++ ch })
  | _ => (Initial, token)
  }
}
let handleGE = (ch, token: itoken) => {
  switch ch {
  | " " => (Initial, token)
  | _ => (Initial, token)
  }
}

let handleIntLitera = (ch, token: itoken) => {
  switch ch {
  | _ if isDigit(ch) => (IntLitera, {tokenType: IntLitera, text: token.text ++ ch})
  | " " => (Initial, token)
  | _ => (Initial, token)
  }
}

let parse = (input: string) => {
  let len = String.length(input)
  let curIndex = ref(0)
  let curState = ref(Initial)
  let curToken = ref({ tokenType: Identity, text: "" })
  while curIndex.contents < len {
    let ch = String.make(1, String.get(input, curIndex.contents))
    let handler = switch curState.contents {
      | Initial => handleInitial
      | ID => handleId
      | GE => handleGE
      | GT => handleGT
      | IntLitera => handleIntLitera
    }
    let (state, tempToken) = handler(ch, curToken.contents)
    curState := state
    curToken := tempToken
    curIndex := curIndex.contents + 1
    if curState.contents === Initial {
      Js.log(curToken.contents)
    }
  }
}

parse("a = 1")