# Network Flow Algorithms

> Added during filling: the strongest corpus topic had no stub note. Cross-links from [[Mixed-Integer Linear Programming]] and [[Algorithmic Bottlenecks and NP-Hard Problems]] point here.
>
> Source basis: Goldberg, Tardos & Tarjan 1990 (Springer, *Algorithms and Combinatorics* 9) — BEST source; Stanford CME 305 lecture; Stanford CS 97SI slides; Swanson & Woolsey (out-of-kilter tutorial); Ishimatsu et al. 2013 (AIAA, generalized MCNF); Trdlička & Hanzálek (distributed MCNF); Trivella et al. 2021 & Karsten et al. 2015 (liner shipping MCNF); Israel & Lund 1999 (penalty-based flow).

**A network flow model is an LP that happens to look like a graph** — nodes, arcs, capacities, and conservation of flow. Because of that structure it solves far faster than a general LP, and for the federal model it is the natural language of *anything that moves*: money between tiers, goods between islands, services between facilities.

## Why flow structure is worth exploiting

**Swanson & Woolsey** (INFORMS Education Series) make the case bluntly:

> "Network flow algorithms have been developed to handle a special class of linear programming problems. These problems may each be described by a network whose links carry flow. Network algorithms take advantage of this special structure to produce an optimal solution much more quickly, with less storage required, and with virtually no round off error in comparison with general linear programming codes."

**Goldberg, Tardos & Tarjan (1990)** open the survey with the field's self-placement:

> "Network flow problems are central problems in operations research, computer science, and engineering and they arise in many real world applications. Starting with early work in linear programming and spurred by the classic book of Ford and Fulkerson [26], the study of such problems has led to continuing improvements in the efficiency of network flow algorithms."

**Ishimatsu et al. (2013)** state the modelling pay-off — LP solves fast and certifiably:

> "One advantage of the LP formulation is that it can be quickly solved and that if solved, the solution is guaranteed to be optimal. This advantage of LP allows us to solve a number of instances."

## The minimum-cost flow formulation

**Ishimatsu et al. (2013)** — the canonical form:

> Minimize `J = Σ_(i,j)∈A c_ij x_ij` (1)
> subject to `Σ_(j:(i,j)∈A) x_ij − Σ_(j:(j,i)∈A) x_ji <= b_i  ∀ i ∈ N` (2a)
> `l_ij <= x_ij <= u_ij  ∀ (i,j) ∈ A` (2b)
> "where u_ij denotes a capacity and l_ij denotes a lower bound, which is zero in most applications. We refer to the constraints in Eqs. (2a) and (2b) as **mass balance constraints** and **flow bound constraints**, respectively."

Read in federal terms: arcs = transfer channels and freight routes between tiers/islands; `c_ij` = unit cost (or penalty — see [[Modeling Federal Constraints & Penalties]]); `b_i` = net supply at node *i* (a rich province emits, a poor province absorbs); `u_ij` = capacity of a shipping lane or a capped transfer window.

## Max flow and the max-flow/min-cut theorem

From the Stanford CME 305 lecture:

> "Corollary 1 (Max-Flow/Min-Cut) The minimum cut value in a network is the same as the maximum flow value. Corollary 2 (Integral Flow) If all edge capacities in a network are non-negative integers, then there exists an integral maximum flow."

And the residual-network idea that powers Ford–Fulkerson:

> "The advantage of the residual network R(N, f) is that any path P from s to t in R(N, f) gives a path along which we can increase the flow, including ones that reverse previously assigned flow. Building the residual network and augmenting along an s-t path forms the core of Ford-Fulkerson algorithm."

**Min-cut's federal meaning:** the cheapest set of arcs whose removal disconnects source from sink is also the maximum flow. If the archipelago is connected to the mainland by three ports, no allocation scheme can move more than those ports carry — **the min cut is the physical upper bound on equalization-by-transport**. Infrastructure investment is exactly the act of raising the min cut.

## The complexity ladder

**Goldberg, Tardos & Tarjan (1990)** give the canonical progression:

> "The first pseudopolynomial algorithm for the maximum flow problem is the augmenting path algorithm of Ford and Fulkerson [27, 26]. Dinic [21] and Edmonds and Karp [22] independently obtained polynomial versions of the augmenting path algorithm."

> "The first pseudopolynomial algorithm for the minimum-cost circulation problem is the out-of-kilter method, which was developed independently by Yakovleva [105], Minty [77], and Fulkerson [32]. The first polynomial algorithm for the minimum-cost circulation problem is due to Edmonds and Karp [22]."

> "The first strongly polynomial algorithm for the minimum-cost circulation problem was designed by Tardos [96]."

With: "An algorithm is strongly polynomial if its running time has a bound that is polynomial in n and m."

Stanford CS 97SI slides make pseudopolynomiality concrete:

> "If the max-flow is f*, the time complexity is O((n + m) f*) — 'Bad' in that it depends on the output of the algorithm — Nonetheless, easy to code and works well in practice"

Full complexity detail: [[Algorithmic Bottlenecks and NP-Hard Problems]].

## Multi-commodity flows: the archipelagic case

Single commodity = one good, one source-sink pair. Real logistics is **multi-commodity** — many goods, many origins and destinations — and this is where the corpus concentrates.

**Trdlička & Hanzálek** formalize the multi-commodity routing problem as LP:

> "The routing problem is described as a minimum-cost multi-commodity network flow problem by Linear programming. Based on the convex programming theory we use the dual decomposition theorem to derive the distributed algorithm."

**Karsten et al. (2015)** draw the complexity line:

> "The MCF problem can be formulated as a linear programming problem which can be solved in polynomial time ... In order to include the transit time constraint one has to solve an extended version of the problem, the time constrained MCF problem, which is NP-hard. This is easily shown by reduction from the shortest weight constrained path problem."

**Ishimatsu et al. (2013)** push the model to a **generalized** MCNF (flows transform at nodes — propellant produced from regolith) and demonstrate the engineering pay-off: "The solution saves 67.5% from the Mars DRA 5.0 reference scenario in terms of the initial mass in low-Earth orbit (IMLEO)".

**Federal reading:** money is closer to a **single commodity** than to multi-commodity freight — a transfer rupiah is fungible. But *service delivery* to islands is genuinely multi-commodity (health, education, fuel, water each with own origins and destinations), which is why the archipelagic model needs both layers.

## Distributed computation of flows — the federal.deep link

**Trdlička & Hanzálek** (sensor networks) compute the optimum **without a central node**:

> "The algorithm computes the energy optimal routing in the network without any central node or the knowledge about the whole network structure. Each node only needs to know the flow which it is supposed to send or receive and the costs and capacities of the neighboring links."

The technique is **dual decomposition** — the centre broadcasts dual variables (shadow prices) and each node optimizes locally. **This is the mathematical form of "decentralized but coordinated" federal planning**: provinces hold their own information (true local costs, local preferences — the Oates/property-rights argument in [[Federation Research/What is Federation]]), the centre sets prices/transfers, and the system reaches the same optimum a central planner would. Information stays local; the allocation stays globally optimal.

## Penalty-based flow — the bridge to the constraint note

**Israel & Lund (1999)** use cost coefficients to encode legal priorities inside a min-cost flow (Truckee-Carson water rights). Their lesson and the scaling warning are in [[Modeling Federal Constraints & Penalties]]:

> "The overarching principle for setting unit penalties for priority-based operations is that senior unit penalties must exceed the combined junior unit penalties for any feasible competing space-time path through the system."

## Where flows sit in this vault

| Need | Model | Note |
|---|---|---|
| Money between tiers | min-cost flow with penalties | this note + [[Modeling Federal Constraints & Penalties]] |
| Goods/services across islands | multi-commodity flow | this note |
| Facility siting | p-median / covering | [[Spatial and Location-Allocation Models]] |
| Fairness hard constraint | LSCP (all covered) | [[What is LP, Why is That Matter]] |

## Related notes
- [[Algorithmic Bottlenecks and NP-Hard Problems]] — the complexity classes above
- [[Graph Modeling with NetworkX]] — the (absent) Python graph layer these models need
- [[Modeling Federal Constraints & Penalties]] — penalties as flow costs
- [[Federation Research/What is Resources Planning]] — the policy chain this formalizes
