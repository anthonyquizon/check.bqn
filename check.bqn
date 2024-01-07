# TODO debug using graphs
⟨Range⟩ ← •MakeRand 10

# limits
ex_lim ← 1000 ⋄ sk_lim ← 1000

# random number ranges
g0r ← 1000 ⋄ g1r ← 1000 ⋄ s0r ← 100

_check_ ← { 
  name←𝕩 ⋄ F←𝔽 ⋄ G←𝔾 

  # increase smallest element
  G0 ← { 𝕊 ⟨⟩ : ⟨Range g0r⟩; 𝕊 𝕩 : { 𝕩+1⌈Range g0r}⌾((⊑⍋𝕩)⊸⊑) 𝕩 } 

  # add new element
  G1 ← { 𝕩∾Range g1r }   

  # reduce largest element
  S0 ← { 𝕊 ⟨⟩ : ⟨⟩; 𝕊 𝕩 : {0⌈(𝕩-(Range s0r))}⌾((⊑⍒𝕩)⊸⊑) 𝕩 } 

  # remove random element
  S1 ← { n←↕≠𝕩 ⋄ /⟜𝕩¬(Range ≠𝕩)=n }

  Grow ← { 𝕊: 
    c←0 ⋄ interesting←0
    b ← {
      c+↩1 ⋄ b ← (Range∘≠⊸⊑0‿0‿0‿0‿1) ◶ G0‿G1 𝕩 
      {¬F G 𝕩}◶⟨{𝕩}, {𝕊: interesting↩1 ⋄ 𝕩}⟩ b
    } •_while_ { 𝕊: (c<1000)∧(¬interesting) } ⟨⟩
    interesting‿b
  }

  Shrink ← {
    same←0 ⋄ p←𝕩 ⋄ c←0 ⋄ interesting←0
    b←{ 𝕊:
      c+↩1 ⋄ b←(Range∘≠⊸⊑0‿0‿0‿0‿1)◶ S0‿S1 𝕩 
      {𝕩≡p}◶⟨{𝕊:same↩0}, {𝕊:same+↩1}⟩ b
      {¬F G 𝕩}◶⟨p, {𝕊:p↩𝕩 ⋄ interesting↩1 ⋄ 𝕩}⟩ b
    } •_while_ { 𝕊: (c<sk_lim) ∧ (same<10) } 𝕩
    p
  }

  OK ← { 𝕊: •Out "✓ " ∾ name }

  Fail ← { 𝕊: 
    •Out "× " ∾ name 
    •Out "  Counter: " ∾ (•Fmt G (Shrink 𝕩))
  }

  interesting‿b ← Grow @
  interesting ◶ OK‿Fail b
}

#F ← { •Show 𝕩⋄n‿(⌊n÷˜≠𝕩)⥊|𝕩 }
F ← { 𝕩 }
•Out "--"

#{ ∧´100>+˝ 𝕩 } _check_ F "should show x"
{ ∧´100>𝕩 } _check_ F "should show x"
•Out "done"
