
> "LSP" is not a defined method in the algorithm corpus. This note resolves the term, documents the corpus's only occurrence, and anchors the note's substance in the nearest defensible topics: **LSCP (Location Set Covering Problem)** and **large-scale (linear) programming**. External verification needed for whichever meaning the paper ultimately intends.

## The corpus's only LSP: Lunar South Pole

A full survey of all 42 algorithm PDFs finds exactly one occurrence of the string "LSP",  it is **not classify as an algorithm**. In Ishimatsu et al.'s (2013) generalized multi-commodity network flow model for space exploration logistics, LSP is a **network node label**:

> node list including "lunar south pole (LSP), Phobos (PHOB), Deimos (DEIM)" (ishimatsu2013, network construction)

The flow table then routes commodities through it, e.g. rows beginning "LSP LLO LOX/LH2 ..." (LLO = low lunar orbit; LOX/LH2 = liquid oxygen/liquid hydrogen propellant). LSP here is a **spatial location in a logistics network**, interesting only as evidence that this corpus thinks in graph nodes when it thinks about space.

## Candidate meanings, ranked by corpus fit

| #   | Expansion                                            | Corpus support                                                                                                                                                                  | Verdict                                                                                               |
| --- | ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| 1   | **LSCP : Location Set Covering Problem**             | STRONG via `300535` (Bearman et al. 2023) location-model taxonomy                                                                                                               | **Most likely intended** if the note pointed at a spatial-optimization acronym; differs by one letter |
| 2   | **Large-Scale (Linear) Programming**                 | MIT 15.053: "theoretically and practically efficient techniques for solving large-scale problems"; Vielma 2015 motivates tighter formulations precisely by solvability at scale | Defensible theme, but **no source uses the abbreviation**                                             |
| 3   | **Lunar South Pole**                                 | Only literal occurrence in corpus (Ishimatsu 2013)                                                                                                                              | Literal but almost certainly not what the note title meant                                            |
| 4   | Least-Squares Programming / Location-Scaling Problem | none                                                                                                                                                                            | **Unsupported**                                                                                       |

## Why LSCP matters (the substantive reading)

If the intended term is **LSCP**, then the question "why does it matter" has a clean answer in the corpus. **Bearman et al. (2023)** sit LSCP inside the standard taxonomy:

> "Location problems are commonly classified into three categories: covering-based problems, median-based problems, and other problems (Daskin, 2008). The covering-based problem can be further divided into Location Set Covering Problem (LSCP), Maximal Covering Location Problem (MCLP), and p-centre location problem. Median-based problems include two main models: p-median location problem, and fixed charge facility location problem (Daskin, 2008)."

The taxonomy's practical significance for archipelagic planning:

| Family | Question it answers | Archipelagic analogue |
|---|---|---|
| **LSCP** (set covering) | Minimum number of facilities that cover **all** demand points within a service radius | How many island clinics/ports must exist so that **every** inhabited island is within reach — and the answer is often infeasible or enormous |
| **MCLP** (maximal covering) | Given a fixed facility budget, maximize covered demand | The realistic archipelagic version: budget fixed, some islands necessarily left uncovered — the formal statement of the mainland–island trade-off in [[Federation Research/Tradeoff With The Federation Resources Planning]] |
| **p-median** | Locate *p* facilities minimizing total (weighted) travel distance | Service-cost equalization across dispersed islands — see [[Spatial and Location-Allocation Models]] |
| **p-centre** | Minimize the worst-case distance (equity objective) | The minimax fairness version of equalization |

**Why this matters philosophically for the paper:** the LSCP family is where *fairness* first becomes a constraint rather than an objective. Covering models force the planner to declare either "everyone must be covered" (hard constraint, possibly infeasible) or "cover as many as budget allows" (soft, objective). That is the same hard/soft distinction that governs federal transfer formulas — see [[Modeling Federal Constraints & Penalties]] and Trivella et al.'s soft transit-time constraints:

> "In practical contexts, however, these hard limits may fail to provide sufficient flexibility since routes with even tiny delays would be discarded." (Trivella et al. 2021)

## Why large-scale programming matters (the alternative reading)

If "LSP" means **large-scale linear programming**, the corpus's support is Vielma (2015): the reason formulation *quality* matters is that real instances are big, and weak formulations die there:

> "A wide range of problems can be modeled as Mixed Integer Linear Programming (MIP) problems using standard formulation techniques. However, in some cases the resulting MIP can be either too weak or too large to be effectively solved by state of the art solvers."

An archipelagic federation with hundreds of islands, dozens of tiers and multi-year horizons is exactly such a large-scale instance — this reading connects to [[Algorithmic Bottlenecks and NP-Hard Problems]].

## Action required before the paper

1. Decide which meaning the paper uses (LSCP is recommended — it connects directly to [[Spatial and Location-Allocation Models]]).
2. Verify the acronym with an external source; the corpus alone cannot settle it.
3. Rename the note or retitle the section accordingly ("Location Set Covering / Spatial Optimization").

## Related notes
- [[Spatial and Location-Allocation Models]] — p-median, MCLP, capacity, full formulations
- [[Algorithmic Bottlenecks and NP-Hard Problems]] — the large-scale reading
- [[Modeling Federal Constraints & Penalties]] — hard vs soft constraint logic
