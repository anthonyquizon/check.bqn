⟨Check⟩ ← •Import "../check.bqn"
⟨Hello⟩ ← •Import "./hello.bqn"

"This is a description" Check     Hello‿{𝕩}
"This is a description" Check {𝕩}‿Hello‿{𝕩}
