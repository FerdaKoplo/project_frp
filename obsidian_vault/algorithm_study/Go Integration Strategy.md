# Go Integration Strategy

> **Status: corpus-ABSENT topic.** Zero of the 42 algorithm PDFs mention Go, Golang, or calling optimizers from Go. The corpus's solver stack is entirely Python (PuLP/CBC, gurobipy, spopt), MATLAB (CPLEX), LINGO, FICO Xpress, and Gurobi. **This note is written from external knowledge and needs verification before the paper.**

## What the corpus establishes (the truth this note must respect)

The optimization layer is settled by the corpus, not by language preference:

- **Python is the corpus's implementation language** — Bearman et al. (2023): "pandas, geopandas, NumPy, gurobipy, spopt"; van Willigen (2023): Gurobi via `gurobipy`; PuLP/CBC inside spopt
- **Solvers are the computational core** — CBC (open-source), Gurobi, FICO Xpress, LINGO, CPLEX (Nordström's SLOPPY'24 survey: "CPLEX (historically), Gurobi, and FICO Xpress; Academic solvers like SCIP and HiGHS are excellent")
- **Reproducibility is the deliverable** — Bearman et al.: GitHub + Zenodo DOI + Jupyter Notebook

Any Go strategy is therefore **not** about replacing the solver. It is about *where the model runs in production*.

## The architecture question this note actually answers

*(External knowledge — verify against current tooling before the paper.)*

| Layer | Corpus-anchored default | Go's potential role | Status |
|---|---|---|---|
| Model formulation & solving | Python (PuLP/gurobipy) | — | settled by corpus |
| Batch / scheduled runs | Python scripts, Jupyter | Go service orchestrating solver runs | external — unverified |
| Data pipeline to fiscal databases | pandas | Go ETL feeding instance data | external — unverified |
| API serving allocations to UIs | none in corpus | Go HTTP service exposing solved allocations | external — unverified |
| Concurrency-heavy heuristic search | GA in Python (Gonçalves-style) | Go goroutines for parallel GA populations | external — unverified |

**Where Go's actual strengths matter for this model:**
- **Deployment simplicity** — single static binary for a government service vs. a Python environment
- **Concurrency** — parallel evaluation of the α-weight sweep (the `T_i = α·Need + (1-α)·CapacityGap − Effort` family across many α values) or parallel GA islands
- **API layer** — the data contract in [[Svelte Visualization Data Contract]] needs a backend; Go is a common choice

## How the model survives the language split — the load-bearing insight

**The formula, not the code, is the legislable artefact.** Because the transfer computation is:

```
T = α · need + (1-α) · (cap_std − cap) − effort
```

—a five-operation vector expression (see [[Vector Math with NumPy]])—it is **implementable in any language, including Go, with identical output**. That is precisely the replicability requirement from Haque et al. Box 11:

> "Any official or private citizen must be able to easily duplicate calculations."

A formula that depends on a specific solver or library is not duplicable; a formula that is arithmetic over published vectors is. **Go integration is trivially honest where the formula is trivially arithmetic**, and it is genuinely needed only for the MILP facility-siting layer.

## The two routes for the MILP layer

*(External — verify)*

1. **Keep Python for solving, Go for everything else.** Go service writes instance JSON, calls a Python solver worker (subprocess or HTTP), reads back the solution. Solver of record stays CBC/Gurobi per the corpus. **Lowest risk; recommended default.**
2. **Call a solver with Go bindings.** e.g. aGo wrappers or C bindings to CBC/HiGHS. Keeps everything in one binary but adds an untested dependency edge — against the corpus's own reproducibility posture.

**Decision rule for the paper:** route 1 unless measured reason to move. The paper's contribution is the model and the formula, not the deployment.

## What must be verified before the paper

1. Whether Go solver bindings are mature enough to replace the Python path (external survey)
2. Whether a government audience needs any of this at all — **possible honest answer: the paper specifies Python only, and Go integration is out of scope.** That is a legitimate finding, not a failure.

## Honest bottom line

**This note may belong in [[Future Model Improvements]] rather than the main line of the paper.** The corpus supports the model; it supports Python; it supports PuLP/CBC/Gurobi. Nothing in it requires Go, and nothing the paper claims depends on Go. Record the intent, mark it external, and do not let an unverified technology choice become load-bearing in the argument.

## Related notes
- [[Resource Allocation with PuLP]] — the corpus-supported implementation
- [[Svelte Visualization Data Contract]] — the other external-side integration point
- [[Future Model Improvements]] — where unverified tooling belongs
- [[Summary of the Algorithmic Approach]] — the architecture this would slot into
