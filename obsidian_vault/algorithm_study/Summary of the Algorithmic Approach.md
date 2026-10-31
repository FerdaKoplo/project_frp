# Summary of the Algorithmic Approach

> Source basis: synthesis across the 15 sibling notes, all anchored in the 42-file algorithm corpus (profile: `.ars-pipeline` corpus profile; extraction cache `/tmp/algotxt/`). See [[What is Operations Research]] for discipline framing.

**The question this vault half answers:** given the archipelagic-federal problem in [[Summary]] , a fixed transfer pool, heterogeneous island need, and a political demand for transparency — *what is the algorithm?*

**Answer in one paragraph.** The problem splits in two, and each half gets a different method. The **transfer computation itself is small and linear**: a five-operation vector formula over published per-province indices, solvable as an LP in milliseconds, implementable in any language, and duplicable by any citizen — which is exactly the replicability standard the fiscal-federalism literature demands. The **facility-and-assignment layer is combinatorial and NP-hard**: which islands get facilities, which islands are served from where — a capacitated p-median / covering MILP, attacked with good formulations, soft-constraint penalties, and, where exact solve fails, genetic algorithms. The two layers are joined by a **cost-of-provision index** that carries archipelagic geography (dispersion, connectivity, climate exposure) into both. Politics sets the objective and the hard constraints; ML estimates the indices; OR computes the allocation.

## The model, stated completely

From [[federation_study/Translating Political Constraints to Algorithmic Rules]] and [[Modeling Federal Constraints & Penalties]]:

```
LAYER 1 — TRANSFER FORMULA (LP; deterministic; legislable)
  T = α · need + (1-α) · (cap_std − cap) − effort
  s.t.  Σ_i T_i = Pool  (fixed share of national revenue growth)
        T_i >= floor_i  (every province positive; anti-dependence)
        T_i <= cap_T    (cap transfer share of budget)
  need, cap, effort: published indices; weights from Israel & Lund
                     priority-preserving preprocessor LP

LAYER 2 — SERVICE SYSTEM (MILP / GA; combinatorial; NP-hard)
  min  Σ_ij c_ij X_ij + penalties(soft rules)
  s.t. assignment (2), capacity (3), predefined (4), open-before-assign (5)
       [Bearman et al. p-median constraints]
  c_ij: cost-of-provision = distance × detour × €/km + fixed
        [van Willigen cost synthesis on synthetic-but-grounded instances]
  exact: PuLP/CBC or Gurobi;   fallback: GA with penalty function
        [Khasnabis & Mathew template]
```

## How the corpus fills the design

| Design need | Corpus solution | Source |
|---|---|---|
| Model class for decisions | MILP — "rigorousness, flexibility and extensive modeling capability" | Floudas & Lin 2005 |
| Transfer as network | min-cost flow with mass balance + bounds | Ishimatsu et al. 2013 |
| Encoding priorities | **unit-penalty preprocessor LP** (the vault's distinctive import) | Israel & Lund 1999 |
| Hard vs soft rules | hard → constraints; soft → objective penalties | Yao 2023; Trivella et al. 2021 |
| Fairness as deviation | abs-value LP trick (`x = x⁺ − x⁻`) | AIMMS Modeling Guide |
| Geography in the model | capacitated p-median + covering taxonomy | Bearman et al. 2023; Daskin taxonomy |
| Instance construction | calibrated synthetic data on real geography | van Willigen 2023 |
| NP-hardness fallback | GA with random keys / penalty function | Gonçalves et al.; Khasnabis & Mathew 2006 |
| Solver speed via ML | RL for cut-generation stopping (+31%) | Ling et al. 2024 |
| Decentralized computation | dual decomposition — centre sets prices, nodes optimize locally | Trdlička & Hanzálek |
| Open-source solver stack | PuLP + CBC inside spopt; 0.2 s on small instances | Bearman et al. 2023 |

## The computation map

```
POLITICAL DESIGN (Federation Research)
  objective  α, hard constraints C1-C7
      ↓
DATA LAYER  need / cap / effort indices
  (ML surrogates where closed form fails — Nevat & Mughal)
  (synthetic instances — van Willigen method)
      ↓
SOLVER LAYER
  Layer 1: LP  →  T_i allocations        (PuLP/CBC — replicable)
  Layer 2: MILP/GA → facility plan       (cbc/gurobi; GA fallback)
      ↓
OUTPUT LAYER  JSON contract (allocations, frontier, coverage, provenance)
  →  visualization (external, unverified — Svelte note)
```

## Method rules the corpus forces on the design

1. **Formulation quality is part of the science** — "there are two aspects of an MIP formulation that usually have a strong impact ... the size and strength of the LP relaxation" (Vielma 2015). Same system, two writings, one solves.
2. **Prefer special structure** — network algorithms "produce an optimal solution much more quickly, with less storage ... and with virtually no round off error" vs general LP codes (Swanson & Woolsey). Money-flow is a network; exploit it.
3. **Soft constraints preserve tractability** — hard time limits flipped polynomial MCF to NP-hard (Karsten et al. 2015); penalties kept it solvable and *saved cost* (Trivella et al. 2021).
4. **Never hand-tune large weights** — "intuitive rules such as c1 << c2 << c3 may not always work" and large values "induce scaling problems" (Israel & Lund 1999). Compute penalty/weight coefficients with the preprocessor LP.
5. **Exploit free integrality** — "if all edge capacities ... are non-negative integers, then there exists an integral maximum flow" (CME 305). Cast as pure flow where possible.
6. **Determinism for the legislable layer** — a transfer that changes with a random seed is a negotiation, not a law (GA randomness in [[Heuristics and Genetic Algorithms]]).
7. **Synthetic instances must be documented to the constant** — detour factor 1.2, €/km, fixed trip cost (van Willigen 2023).

## Honest limits (carried into [[Future Model Improvements]])

- **Three corpus-ABSENT topics**: NetworkX, Go, Svelte — implemented only with external, unverified knowledge; none is load-bearing in the paper's argument.
- **LSP is undefined in the corpus** — disambiguated toward LSCP in [[What is LP, Why is That Matter]]; needs external confirmation.
- **No corpus source models fiscal-federalism design as such** — the federal translation is this vault's synthesis from penalty/constraint analogues; the Federation Research half supplies the political rules.
- **Synthetic instances test mechanism, not magnitudes** — no empirical validation of the cost-of-provision index yet (Federation Research Gap 4).

## Note map

**Foundations:** [[What is Operations Research]] · [[Mixed-Integer Linear Programming]] · [[Network Flow Algorithms]]
**Method:** [[Algorithmic Bottlenecks and NP-Hard Problems]] · [[Modeling Federal Constraints & Penalties]] · [[Heuristics and Genetic Algorithms]]
**Application:** [[Spatial and Location-Allocation Models]] · [[Resource Allocation with PuLP]] · [[Vector Math with NumPy]] · [[Synthetic Data Generation]]
**Integration:** [[Operations Research vs Machine Learning]] · [[Graph Modeling with NetworkX]] · [[Go Integration Strategy]] · [[Svelte Visualization Data Contract]]
**Unresolved:** [[What is LP, Why is That Matter]] · [[Future Model Improvements]]

## Related notes
- [[Federation Research/Summary]] — the policy half this vault formalizes
- [[Federation Research/Translating Political Constraints to Algorithmic Rules]] — the joint synthesis point of both vaults
