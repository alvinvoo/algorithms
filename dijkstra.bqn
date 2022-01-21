#adjacency list
#A B 4
#A C 2
#B E 3
#C D 2
#C F 4
#D E 3
#D F 1
#E F 1

While ← {𝕩{𝔽⍟𝔾∘𝔽_𝕣_𝔾∘𝔽⍟𝔾𝕩}𝕨@}´

# keys 'A' - 'F'
keys ← 'A'‿'B'‿'C'‿'D'‿'E'‿'F'
adjList1 ← ⟨
  ⟨'B'‿4, 'C'‿2⟩,
  ⟨'E'‿3, 'A'‿4⟩,
  ⟨'D'‿2, 'F'‿4, 'A'‿2⟩,
  ⟨'E'‿3, 'F'‿1, 'C'‿2⟩,
  ⟨'F'‿1, 'D'‿3, 'B'‿3⟩,
  ⟨'D'‿1, 'E'‿1, 'C'‿4⟩
⟩
# Sort Function 
FSortDistList ← (⍋1⊸⊏˘∘>)⊸⊏

Dijkstra ← {
  start ← 𝕨
  end ← 𝕩

  # Priority node queue
  arr ← ∞⥊˜≠keys
  i ← keys ⊑∘⊐ start 
  # replace the `start` value with 0
  pQ ← keys∾¨0⌾(i⊸⊑) arr
  # looks like ⟨ ⟨ 'A' 0 ⟩ ⟨ 'B' ∞ ⟩ ⟨ 'C' ∞ ⟩ ⟨ 'D' ∞ ⟩ ⟨ 'E' ∞ ⟩ ⟨ 'F' ∞ ⟩ 

  # Distance list
  distList ⇐ 0⌾(i⊸⊑)arr
  done ← 0

  # Previous list
  prevList ⇐ 0⥊˜≠keys # simply, @ cannot be used 

  While {𝕤⋄(done≠1) ∧ (0<≠pQ)}‿{𝕤
    # sort, get smallest value and drop + reassign
    pQ ↩ FSortDistList pQ
    smallestNode←⊑⊑pQ
    pQ ↩ 1↓pQ

    {
      smallestNode≡end ? done↩1 ; 
      #find all neighboring nodes of this `smallest`
      nbNodes←⊑smallestNode(keys⊸=)⊸/adjList1

      smDist←⊑smallestNode(keys⊸=)⊸/distList 

      candidateDist←smDist+1⊑¨nbNodes

      nbNn←keys⊐⊑¨nbNodes
      sC←candidateDist<nbNn⊸⊏distList
      nCInd←sC/nbNn
      candidateDist /˜↩sC

      distList↩candidateDist⌾(nCInd⊸⊏)distList
      prevList↩((≠nCInd)⥊smallestNode)⌾(nCInd⊸⊏)prevList

      pQ ∾↩ (nCInd⊏keys)∾¨candidateDist
    }
  }

  cost ⇐ ⊑end(keys⊸=)⊸/distList

  path ⇐ end {
    𝕩≢0 ? n←⊑𝕩(keys⊸=)⊸/prevList ⋄ (n∾𝕨)𝕊n ; 1↓𝕨
  } end
}

dOutput ← 'A' Dijkstra 'C'

•Show dOutput.distList
•Show dOutput.prevList

•Show dOutput.cost
•Show dOutput.path

