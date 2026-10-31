# Svelte Visualization Data Contract

> **Status: corpus ABSENT topic.** Zero of the 42 algorithm PDFs mention Svelte, JavaScript, or a UI data contract. The corpus's notion of "output" is a paper PDF with figures. This note defines the contract the **model side** must emit, anchors the few corpus practices that exist, and marks Svelte/frontend specifics as **external knowledge requiring verification**.

## What the corpus actually gives: three seed practices

**1. The reproducible-workflow posture.** **Bearman et al. (2023)**, on the output of their location-allocation app:

> "Research data and code supporting this publication will be available via a GitHub repository including a reproducible example. This will be linked to a DOI generated through Zenodo. The computational workflow supporting the location-allocation work in the spopt library will be available as a Jupyter Notebook."

And their data flow: "the flow of data between the source (IOE), the App and the spopt library" a named pipeline from data source, application, optimizer, result.

**2. The solution is policy-readable numbers.** Bearman et al.'s result is reported as:

> "public transport travel time reduced by 891 minutes overall for an initial sample of 93 students (9.58 minutes per student)."

A UI for the federal model must surface exactly the same kind of thing: **per-province allocations, per-island coverage, travel-time/cost deltas**.

**3. Pareto frontiers as the contested output.** **Luna Rojas & Flores de la Mota (2022)** define what "result" means when objectives compete:

> "A solution x is Pareto optimal if it is not possible to move from that point and improve at least one objective function without detriment to another objective function."

A visualization of a multi-objective federal plan does not show one answer — it shows a **frontier** from which a political choice must be made. The data contract therefore must carry the frontier, not a single point.
## The data contract (model side : corpus-anchored)

The optimization layer should emit a document with this shape. Every field traces to a corpus concept:

| Field | Content | Corpus anchor |
|---|---|---|
| `scenario_id`, `alpha` | run identifier; the equity weight α | Luna Rojas (multiobjective α sweep) |
| `allocations[]` | per-province/island `T_i`, need, capacity, effort | Federation Research synthesis formula |
| `assignments[]` | facility-island assignments `X_ij`, openings `Y_j` | Bearman et al. p-median model |
| `frontier[]` | (equity, efficiency, coverage) points across α | Luna Rojas Pareto definition |
| `coverage` | fraction of islands within service radius; the MCLP quantity | Bearman et al. taxonomy (MCLP) |
| `diagnostics` | solve time, solver status, gap | CPLEX/Gurobi standard output (van Willigen; Yao) |
| `provenance` | input dataset hash, parameter values, solver version | Bearman et al. reproducibility posture |

**Rule of thumb:** the contract should contain enough that a reviewer with only the JSON can **re-verify the arithmetic** — the Haque et al. Box 11 standard, "any official or private citizen must be able to easily duplicate calculations" ([[Federation Research/Translating Political Constraints to Algorithmic Rules]]).

## Why the contract is the honest core, Svelte is the interchangeable end

The paper's claim does not depend on any frontend framework. What it *does* depend on is that the model's output is **a well-formed, documented, reproducible artefact**. The contract above is a research deliverable; Svelte is one possible renderer for it. Separate the two:

- **Contract = research output** (defensible here, corpus-anchored)
- **Svelte rendering = implementation choice** (external, unverified, honestly out of scope for the paper's argument)

This mirrors [[Go Integration Strategy]]'s conclusion: deployment technology must not become load-bearing in a modelling argument. Both belong in [[Future Model Improvements]] unless the paper's scope explicitly includes a working application.

## Interaction design principle (derived, not quoted)

A federal allocation visualization answers two question types:

1. **"What does my province/island get?"** row-level allocation view (`allocations[]`)
2. **"Why?"** decomposition view showing need/capacity/effort terms and the frontier position (`frontier[]`)

The second is where the politics lives, showing *why* an island's transfer fell is the transparency mechanism the whole vault argues for. **The data contract's `allocations` + `frontier` split is the technical form of that accountability.**

## Verification tasks before any implementation

1. Svelte API and charting library choices (external)
2. Whether the paper includes an application at all — if not, this note contracts to the JSON schema above
3. If included, decide live-solver mode vs. static precomputed results (static is honest and reproducible; live is interactive but harder to certify)

## Related notes
- [[Go Integration Strategy]] — the other external integration point
- [[Resource Allocation with PuLP]] — the solver that produces this data
- [[Synthetic Data Generation]] — the inputs whose outputs get visualized
- [[Federation Research/Translating Political Constraints to Algorithmic Rules]] — the transparency requirement this contract serves
