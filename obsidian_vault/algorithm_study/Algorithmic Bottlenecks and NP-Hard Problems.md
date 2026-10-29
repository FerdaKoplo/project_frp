# Algorithmic Bottlenecks and NP-Hard Problems

> Source basis: Floudas & Lin 2005; Karsten et al. 2015 (TR-E); Gonçalves, Mendes & Resende 2004/2009; van Willigen 2023; Goldberg, Tardos & Tarjan 1990; CME 305 lecture (Stanford); CS 97SI slides (Stanford); Vielma 2015; Ling et al. 2024. See [[Summary of the Algorithmic Approach]].

Adding one word — "integer" — to a linear program moves the problem from *tractable* to *exponentially hard in the worst case*. This note collects the corpus's complexity results and the practical answers to them.

## The core fact: integrality → NP-completeness

**Floudas & Lin (2005)**, on process scheduling:

> "These process scheduling problems are inherently combinatorial in nature because of the many discrete decisions involved, such as equipment assignment and task allocation over time. They belong to the set of NP-complete problems (Garey and Johnson, 1979), which means that the solution time scales exponentially as the problem size increases in the worst case. This has important implications for the solution of scheduling problems."

**Gonçalves, Mendes & Resende**, on the resource-constrained multi-project scheduling problem (RCMPSP):

> "It has been shown by Blazewicz et al. (1983) that the RCPSP, as a generalization of the classical job shop scheduling problem, belongs to the class of NP-hard optimization problems (Garey and Johnson, 1979). The RCMPSP, as a generalization of the RCPSP, is therefore also NP-hard."

**van Willigen (2023)**, on capacitated location-allocation:

> "The uncapacitated facility location problems (UFLP) are NP-hard, and thus the model used in this thesis is also NP-hard since it includes the UFLP."

**Karsten et al. (2015)** give the sharpest contrast in the corpus — the same problem family, one version easy, one version hard:

> "The MCF problem can be formulated as a linear programming problem which can be solved in polynomial time and there are many algorithms for solving it. One of these methods is by delayed column generation ... In order to include the transit time constraint one has to solve an extended version of the problem, the time constrained MCF problem, which is NP-hard. This is easily shown by reduction from the shortest weight constrained path problem, (Garey and Johnson, 1979)."

**Lesson for the federal modeller:** a single extra constraint class (here: transit-time deadlines) flipped a polynomial problem to NP-hard. In the archipelagic transfer model, adding "each island must be served within X" as a **hard** constraint risks the same flip — which is precisely the argument Trivella et al. (2021) make for **soft** penalty constraints instead. See [[Modeling Federal Constraints & Penalties]].

## The complexity ladder (network-flow evidence)

From **Goldberg, Tardos & Tarjan (1990)** and the Stanford lecture notes:

| Class | Definition | Corpus example |
|---|---|---|
| **Pseudopolynomial** | Runtime depends on the *magnitude* of numbers in input, not just input size | Ford–Fulkerson augmenting path for max flow; "The first pseudopolynomial algorithm for the maximum flow problem is the augmenting path algorithm of Ford and Fulkerson" |
| **Polynomial** | Polynomial in input size | Edmonds–Karp: "Dinic [21] and Edmonds and Karp [22] independently obtained polynomial versions of the augmenting path algorithm"; also "The first polynomial algorithm for the minimum-cost circulation problem is due to Edmonds and Karp" |
| **Strongly polynomial** | "An algorithm is strongly polynomial if its running time has a bound that is polynomial in n and m" — independent of numeric magnitudes | Tardos: "The first strongly polynomial algorithm for the minimum-cost circulation problem was designed by Tardos" |

The Stanford CS 97SI slides give the concrete taste of pseudopolynomiality:

> "If the max-flow is f*, the time complexity is O((n + m) f*) — 'Bad' in that it depends on the output of the algorithm — Nonetheless, easy to code and works well in practice"

**Why the distinctions matter for a fiscal model:** transfer formulas contain enormous monetary magnitudes. A pseudopolynomial algorithm (runtime scaling with capacity values) is unusable on a national budget; strongly polynomial algorithms are safe. Worst-case bounds and practical performance also diverge — Ford–Fulkerson is "bad" in theory and "works well in practice."

## The max-flow/min-cut theorem — the one proof the paper can rely on

From the Stanford CME 305 lecture:

> "Corollary 1 (Max-Flow/Min-Cut) The minimum cut value in a network is the same as the maximum flow value. Corollary 2 (Integral Flow) If all edge capacities in a network are non-negative integers, then there exists an integral maximum flow."

The integral-flow corollary is a gift to the federal modeller: **when capacities are integers, an optimal integer solution exists automatically** — no explicit integrality requirement, no NP-hardness. Where a model can be cast as a pure network flow (transshipment of a divisible budget across a tier hierarchy), integrality comes free. Where it cannot — assignments, openings, choices — NP-hardness arrives. This is the deep reason the corpus insists on exploiting "special structure" (Swanson & Woolsey).

## Formulation quality as the bottleneck driver

**Vielma (2015)** reframes the bottleneck from problem-inherent to formulation-contingent:

> "in some cases the resulting MIP can be either too weak or too large to be effectively solved by state of the art solvers ... there are two aspects of an MIP formulation that usually have a strong impact ... the size and strength of the LP relaxation, and the effect of branching on the formulation."

The bottleneck is often not the problem — it is the **writing down** of the problem.

## Solver-internal bottlenecks: when to stop

**Ling, Wang & Wang (AAAI-24)**, on the cut-generation stopping problem:

> "A key problem for cuts is when to stop cuts generation, which is important for the efficiency of solving MILPs. However, many modern MILP solvers employ hard-coded heuristics to tackle this problem, which tends to neglect underlying patterns among MILPs from certain applications."

## Practical answers in this corpus

| Answer | Source | Where it lands in this vault |
|---|---|---|
| Use LP/network-flow structure where possible | Swanson & Woolsey (special structure ⇒ "much more quickly, with less storage required, and with virtually no round off error") | [[Network Flow Models]] |
| Write stronger/sharper formulations | Vielma 2015 | [[Mixed-Integer Linear Programming]] |
| Soften hard constraints into penalties | Trivella et al. 2021; Yao 2023 hard/soft rule | [[Modeling Federal Constraints & Penalties]] |
| Trade exactness for speed with heuristics/GA | Gonçalves et al.; Khasnabis & Mathew | [[Heuristics and Genetic Algorithms]] |
| Let ML tune solver internals | Ling et al. 2024 (HYGRO, +31%) | [[Operations Research vs Machine Learning]] |
| Build small synthetic instances for development | van Willigen 2023 | [[Synthetic Data Generation]] |

## Honest consequence for the archipelagic model

A national archipelagic resource plan with integer assignment decisions (which islands get which facilities, which provinces are "special status") is **NP-hard by construction**. The paper's synthesis formula `T_i = α·Need(i) + (1-α)·CapacityGap(i) − Effort(i)` (see [[Federation Research/Translating Political Constraints to Algorithmic Rules]]) is computationally trivial — it is the **index construction** (need, capacity, effort from heterogeneous data) that carries the difficulty, and that is a data and measurement problem, not an NP-hardness problem. Stating this distinction honestly is part of the contribution, not a weakness.

## Related notes
- [[Mixed-Integer Linear Programming]] — where integrality enters
- [[Heuristics and Genetic Algorithms]] — the standard escape hatch
- [[Modeling Federal Constraints & Penalties]] — soft constraints as complexity control
