# TODO debug using graphs
⟨Range⟩ ← •MakeRand 10

# limits
ex_lim ← 1000 ⋄ sk_lim ← 1000

# random number ranges
g0r ← 1000 ⋄ g1r ← 1000 ⋄ s0r ← 100

_check_ ← { 
  name←𝕩 ⋄ F←𝔾 ⋄ G←𝔽
  •Show name
  # increase smallest element
  G0 ← { 𝕊 ⟨⟩ : ⟨Range g0r⟩; 𝕊 𝕩 : { 𝕩+1⌈Range g0r}⌾((⊑⍋𝕩)⊸⊑) 𝕩 } 
  # add new element
  G1 ← { 𝕩∾Range g1r }   
  # reduce largest element
  S0 ← { 𝕊 ⟨⟩ : ⟨⟩; 𝕊 𝕩 : {0⌈(𝕩-(Range s0r))}⌾((⊑⍒𝕩)⊸⊑) 𝕩 } 
  # remove random element
  S1 ← { n←↕≠𝕩 ⋄ /⟜𝕩¬(Range ≠𝕩)=n }

  Grow ← { 𝕊: 
    c←0 ⋄ z←0
    b ← {
      c+↩1 ⋄ b ← (Range∘≠⊸⊑0‿0‿0‿0‿1) ◶ G0‿G1 𝕩 
      {¬F G 𝕩}◶⟨{𝕩}, {𝕊: z↩1 ⋄ 𝕩}⟩ b
    } •_while_ { 𝕊: (c<1000)∧(¬z) } ⟨⟩
    z‿b
  }

  Shrink ← {
    same←0 ⋄ p←𝕩 ⋄ c←0 ⋄ z←0
    b←{ 𝕊:
      c+↩1 ⋄ b←(Range∘≠⊸⊑0‿0‿0‿0‿1)◶ S0‿S1 𝕩 
      {𝕩≡p}◶⟨{𝕊:same↩0}, {𝕊:same+↩1}⟩ b
      {¬F G 𝕩}◶⟨p, {𝕊:p↩𝕩 ⋄ z↩1 ⋄ 𝕩}⟩ b
    } •_while_ { 𝕊: (c<sk_lim) ∧ (same<10) } 𝕩
    p
  }

  OK ← { 𝕊: •Out "✓ " ∾ name }

  Fail ← { 𝕊: 
    •Out "× " ∾ name 
    •Out "  Counter: " ∾ (•Fmt G (Shrink 𝕩))
  }

  z‿b ← Grow @
  z ◶ OK‿Fail b
}
#F ← { •Show 𝕩⋄n‿(⌊n÷˜≠𝕩)⥊|𝕩 }
#F ← { 𝕩 }
#•Out "--"

##{ ∧´100>+˝ 𝕩 } _check_ F "should show x"
#{ ∧´100>𝕩 } _check_ F "should show x"
#•Out "done"

type ← { none⇐0 ⋄ comment⇐1 ⋄ bang⇐2 ⋄ spec⇐3 ⋄ nl⇐4 ⋄ arr⇐5 }

NsCheck ⇐ {
  l ← •file.Lines 𝕩
  ns ← •Import 𝕩
  # uppercased namespace
  k ← -⟜(32×1="a{"⊸⍋)⌾⊏¨•ns.Keys ns
  # remove newlines and flatten
  l ↩ l/˜0≠≠¨l ⋄ t ← @
  #  find lines with function names and →
  # split by →

  # build array of functions with _check_ 

  # specs: lines with functions from namespaces
  sp ← l/˜(⥊k∨´∘⍷⌜l)∧(∨´¨'→'⊸=¨l)
  sp ↩ {
    m ← +`'→'=𝕩
    f ← 𝕩/˜¬m
    # TODO split by {}
    fn ← (f=' ')(+`-1˙)⊸⊔ f
    fn ↩ fn/˜0≠≠¨{𝕩/˜ ' '≠𝕩}¨fn
    #•Show ≠ fn

    #r ← 𝕩/˜»m
  } ¨sp

  {
      𝕊 f‿a   : 
        •Show "running" 
        (•BQN a) _check_ ns.Hello "test"
    ; 𝕊 b‿f‿a : 
      •Show "not running" 
      ⟨⟩
    ; 𝕊 a : 
        •Show "not running" 
      ⟨⟩
  } ¨ sp

  #•Show file↩ ∾(@+10)⊸∾¨⟨
    #"⟨_check_⟩ ← •Import ""check.bqn"" "
    #"ns ← •Import """ ∾ 𝕩 ∾""""
  #⟩ ∾ file

  #•BQN  file

  #•Show (=⟜''∨=⟜'=')¨l
  

  #•Show t

  #{ s←t=type.comment∧t=type.bang
  #}

  # if line contains function name and arrow


  l
  # get descriptions
  # get all lines with function name
}

•Show "---"
NsCheck "examples/hello.bqn"

# properties

# parse file

# generate check file
