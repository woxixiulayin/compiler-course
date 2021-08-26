let isDigit = ch => Js_re.test_(%re("/[0-9]/"), ch)
let isAlpha = ch => Js_re.test_(%re("/[a-zA-Z]/"), ch)

// token类型
type tokenType = [
| #Identity
| #IntLiteral
| #GT
| #GE
| #Assign
]

// 有限状态机状态
type state = [
| #Initial
| tokenType
]


// 关键字
type keyword = [ #"int" ]

// 处理初始状态
let handleInitial = ch => {
  switch ch {
    | _ if isDigit(ch) => #IntLiteral
    | ">" => #GT
    | " " => #Initial
    | "=" => #Assign
    | _ => #Identity
  }
}

// 处理ID状态
let handleId = ch => {
  switch ch {
  | " " => #Initial
  | _ => #Identity
  }
}


let handleGT = ch=> {
  switch ch {
  | " " => #Initial
  | "=" => #GE
  | _ => #Initial
  }
}
let handleGE = ch => {
  switch ch {
  | " " => #Initial
  | _ => #Initial
  }
}

let handleIntLiteral = ch => {
  switch ch {
  | _ if isDigit(ch) => #IntLiteral
  | " " => #Initial
  | _ => #Initial
  }
}
let handleAssign = ch => {
  switch ch {
  | _ => #Initial
  }
}

let parse = (input: string) => {
  let len = String.length(input)
  let curIndex = ref(0)
  let currentContent = ref("")
  let lastState: ref<state> = ref(#Initial)
  while curIndex.contents <= len {
    let ch = Js.String.get(input, curIndex.contents)
    let currentState = switch lastState.contents {
    | #Initial => handleInitial(ch)
    | #Identity => handleId(ch)
    | #IntLiteral => handleIntLiteral(ch)
    | #GT => handleGT(ch)
    | #GE => handleGE(ch)
    | #Assign => handleAssign(ch)
    }

    if currentState === #Initial && lastState.contents !== #Initial {
      Js.log(`${currentContent.contents} ${lastState.contents :> string}`)
      currentContent := ""
    } else {
      currentContent := currentContent.contents ++ ch
    }
    curIndex := curIndex.contents + 1
    lastState := currentState
  }

}

parse("int age = 1222")