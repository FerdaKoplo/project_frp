# Graph Modeling with NetworkX

> **Status: corpus-ABSENT topic.** Zero of the 42 algorithm PDFs mention NetworkX (verified by grep). Graph *mathematics* is everywhere in the corpus; the Python *library* is nowhere. This note assembles what the corpus gives mathematically, states what NetworkX would add, and marks the library details as **external knowledge requiring verification**.

## What the corpus gives: the graph is the model

Three corpus sources build graph models explicitly:

**Ishimatsu et al. (2013)** — the most self-conscious graph modeller in the corpus:

> "The objective of this paper is to develop a comprehensive graph-theoretic modeling framework to quantitatively evaluate and optimize space exploration logistics from a 'network' perspective."

Their node list is the model: "lunar south pole (LSP), Phobos (PHOB), Deimos (DEIM)" — each candidate depot or ISRU site becomes a node; each transport leg becomes an arc with cost and capacity. **This is exactly how an archipelago should be modelled: inhabited islands = nodes, shipping lanes = arcs, port capacity = arc bound.**

**Stanford CME 305 lecture** — the residual network as a graph construction:

> "The advantage of the residual network R(N, f) is that any path P from s to t in R(N, f) gives a path along which we can increase the flow, including ones that reverse previously assigned flow. Building the residual network and augmenting along an s-t path forms the core of Ford-Fulkerson algorithm."

**Stanford CS 97SI slides** — max flow, min cut, bipartite matching, min-cost max-flow, all as graph problems (slide deck, 6.5 KB).

**Goldberg, Tardos & Tarjan (1990)** — the algorithms run on adjacency structure: n nodes, m arcs, complexity bounds "polynomial in n and m".

## The gap: no Python graph code anywhere

What the corpus's applied papers use:

| Paper | Graph software | Role |
|---|---|---|
| Bearman et al. 2023 (p-median) | pandas, geopandas, NumPy, gurobipy, spopt | spatial data + solver; **no graph library** — the network is implicit in the cost matrix `c_ij` |
| van Willigen 2023 (location-allocation) | Gurobi, custom GA | same — cost matrix, not graph object |
| Ishimatsu et al. 2013 | MATLAB `cplexlp` | graph built in MATLAB |
| Trdlička & Hanzálek | distributed algorithm in-network | the network *is* the deployment |

**Key observation:** in every applied case the "graph" is operationalized as a **cost/distance matrix**, not as a graph data structure. For optimization itself this is enough — solvers consume matrices. A graph library becomes necessary only for **graph algorithms** (connectivity checks, shortest paths, MST, max flow) or for **model construction from geographic data** (build the network from ports and lanes before computing costs).

## What NetworkX would add *(external knowledge — verify before paper)*

| Capability | Why the archipelagic model needs it | Corpus support for the need |
|---|---|---|
| Build graph from island coordinates + port list | constructing arcs for Ishimatsu-style network modelling | Ishimatsu's graph-theoretic framework motivates it; no code |
| Shortest paths (Dijkstra) | distance basis for the cost-of-provision index `c_ij` | van Willigen uses Euclidean × 1.2 instead ([[Synthetic Data Generation]]) — a *graph* shortest path would be the honest measure over sea lanes |
| Connectivity analysis | which islands can reach which — identifies the min-cut constraint | CME 305 max-flow/min-cut gives the theory |
| Max-flow / min-cost-flow solvers | validate LP results against specialized algorithms | Swanson & Woolsey on special structure |
| Centrality / betweenness | identify chokepoint ports for infrastructure priority | **no corpus source** — marked as external |
| Generation of synthetic networks | test instances with realistic topology | van Willigen's synthetic-data method is geographic, not graph-based |

**Honest framing for the paper:** NetworkX belongs to the *implementation* layer, not the scientific layer. The paper can specify the model fully (nodes, arcs, costs, capacities) without it, and name NetworkX as the intended construction tool with API details verified externally.

## The minimal network the federal model needs

Stated graph-theoretically (corpus-derived):

```
G = (N, A)
  N = {islands, mainland hubs, tier capitals}          each with:
        b_i  net fiscal supply/demand                  (Ishimatsu mass balance)
        need_i, capacity_i, effort_i                   (federal formula inputs)
  A = {feasible transfer/transport relations}          each with:
        c_ij  unit cost or penalty                     (Israel & Lund priorities)
        u_ij  capacity (port, shipping lane, budget window)
        l_ij  lower bound (usually 0)
  solve:  min Σ c_ij x_ij
          s.t.  mass balance (2a), flow bounds (2b)    (Ishimatsu formulation)
```

That is a complete graph model of the archipelagic transfer system, and every element is corpus-anchored. **The math is done; only the Python glue is missing.**

## Verification tasks before the paper

1. Confirm NetworkX API for graph construction and shortest paths (external).
2. Decide whether sea-lane distances replace van Willigen's Euclidean ×1.2 approximation.
3. If max flow is used to bound transport capacity, cross-check CME 305 formulation against NetworkX docs.

## Related notes
- [[Network Flow Algorithms]] — the algorithms that run on this graph
- [[Spatial and Location-Allocation Models]] — where geography becomes `c_ij`
- [[Synthetic Data Generation]] — van Willigen's geographic instance construction
- [[Vector Math with NumPy]] — the numerical layer underneath
