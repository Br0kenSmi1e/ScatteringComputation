#import "@preview/touying:0.4.2": *
#import "@preview/touying-simpl-hkustgz:0.1.0" as hkustgz-theme
#import "@preview/cetz:0.2.2": canvas, draw, tree

#let vertex(location, name, color) = {
  import draw: *
  circle(location, radius: 4pt, name: name, fill: color)
}
#let edge(from, to) = {
  import draw: *
  line(from, to, name:"line")
}
#let s = hkustgz-theme.register()

// Global information configuration
#let s = (s.methods.info)(
  self: s,
  title: [Universal Computation by Quantum Scattering],
  subtitle: [],
  author: [Longli Zheng],
  date: datetime.today(),
  institution: [HKUST(GZ)],
)

// Extract methods
#let (init, slides) = utils.methods(s)
#show: init

// Extract slide functions
#let (slide, empty-slide, title-slide, outline-slide, new-section-slide, ending-slide) = utils.slides(s)
#show: slides.with()

#outline-slide()

= Scattering Problem

== Problem Setup

+ Free particles are easy to solve.

+ Particles in potential fields are usually hard to solve.

+ If the initial state and the final state are free, the potential shows up as a perturbation.

== Rutherford Scattering
#slide(composer: (1fr, 1fr))[
The trajectory is determined by energy and angular momentum.

$ T = T(L,E), L = p b, E = frac(p^2, 2m) $

The scattered state, described by the scattered angle, is determined by the impact parameter $b$ and momentum $p$.

$ theta = theta (p,b) $
][
#place(center,
dy: 0pt,
image("rutherford.png")
)
]

== Quantum Scattering

#slide(composer: (1.2fr, 0.8fr))[
Due to superposition principle, the scattered state may be a superposition of states on different "trajectories".

$ psi_("in")(k) = e^(- i omega t) e^(-i k x ), 
psi_("out")(k) = e^(- i omega t) sum_(k') S_(k k') e^(i k' x) , $
$ psi_("sc")(k) = e^(- i omega t) (delta_(k k') e^(-i k x )+sum_(k') S_(k k') e^(i k' x)) $

The S-matrix is vital to scattering problem.
The orthonormality of $psi_"sc" (k)$ proves the unitarity of S-matrix.
][

#image("quantum.gif")

]

= Quantum Mechanics on Graphs

== Quantum Evolution on Graphs (Quantum Walk)

#slide(composer: (0.8fr, 1fr))[
For a given graph $G$, its vertices correspond to states of a system,
its adjacency matrix corresponds to Hamiltonian of the system.

][

#place(top + left,
  dx: 10pt,
  dy: -20pt,
  canvas({
  import draw: *
  edge((0,0),(2,0))
  edge((1,0),(1,1))
  edge((1,1),(0,2))
  edge((1,1),(2,2))
  edge((1,3),(0,2))
  edge((1,3),(2,2))
  vertex((0,0),"1",blue)
  content((0,-0.5), text(black, "1"))
  vertex((1,0),"2",blue)
  content((1,-0.5), text(black, "2"))
  vertex((2,0),"3",blue)
  content((2,-0.5), text(black, "3"))
  vertex((1,1),"4",blue)
  content((1.5,1), text(black, "4"))
  vertex((0,2),"5",blue)
  content((-0.5,2), text(black, "5"))
  vertex((2,2),"6",blue)
  content((2.5,2), text(black, "6"))
  vertex((1,3),"7",blue)
  content((1,3.5), text(black, "7"))
  content((8, 0), [$ H &= attach(limits(sum), b: (i,j) in E(G)) |i angle.r angle.l j| \
  &= mat(0, 1, 0, 0, 0, 0, 0;
        1, 0, 1, 1, 0, 0, 0;
        0, 1, 0, 0, 0, 0, 0;
        0, 1, 0, 0, 1, 1, 0;
        0, 0, 0, 1, 0, 0, 1;
        0, 0, 0, 1, 0, 0, 1;
        0, 0, 0, 0, 1, 1, 0
  
  )$])
})
)
]

== Free Particles on Graphs

#place(top + center,
  dx: 0pt,
  dy: 40pt,
  canvas({
  import draw: *
  edge((-2,0),(2,0))
  vertex((0,0),"1",blue)
  content((0,-0.5), text(black, $x$))
  vertex((-2,0),"2",blue)
  content((-2,-0.5), text(black, $x-1$))
  vertex((2,0),"3",blue)
  content((2,-0.5), text(black, $x+1$))
  content((3,0.2),text(black, "..."))
  content((-3,0.2),text(black, "..."))

content((0,-6), [
For an infinite path graph, its Hamiltonian is
$H = limits(sum)_(x in ZZ) |x angle.r angle.l x+1| + |x+1 angle.r angle.l x|.$

Consider a plane wave
$|"pl"(k) angle.r = limits(sum)_(x in ZZ) e^(i k x) |x angle.r$
and we have
$ H|"pl"(k) angle.r &= limits(sum)_(x in ZZ) e^(i k x)(|x-1 angle.r + |x+1 angle.r)\
&= limits(sum)_(x in ZZ) (e^(i k (x+1)) + e^(-i k (x-1)))|x angle.r\
&=2 cos k|"pl"(k) angle.r $

So a particle is "free" when it is on an infinite path graph.])
 }))

== Scattering Problem on Graphs

#slide(composer: (1fr, 1fr))[
#place(bottom, dy: -40pt)[As defined in "normal" QM, scattering process should take a set of plane wave eigen-states to another.
So the scattering process corresponds to a graph shown below.]
#place(top + center,
  dx: 0pt,
  dy: 0pt,
  canvas({
  import draw: *
  edge((-28.28pt,28.28pt),(-2,2))
  edge((-28.28pt,-28.28pt),(-2,-2))
  arc((-28.28pt,28.28pt), start: 135deg, stop: -135deg, radius: 40pt)
  vertex((-28.28pt,28.28pt),"1",white)
  vertex((-2,2),"3",blue)
  vertex((-28.28pt,-28.28pt),"1",white)
  vertex((-2,-2),"4",blue)
  circle((-2.3,2.3), radius: 1pt, fill: black)
  circle((-2.6,2.6), radius: 1pt, fill: black)
  circle((-2.9,2.9), radius: 1pt, fill: black)
  circle((-2.3,-2.3), radius: 1pt, fill: black)
  circle((-2.6,-2.6), radius: 1pt, fill: black)
  circle((-2.9,-2.9), radius: 1pt, fill: black)
  circle((-40pt,0), radius: 1pt, fill: black)
  circle((-36.96pt,15.31pt), radius: 1pt, fill: black)
  circle((-36.96pt,-15.31pt), radius: 1pt, fill: black)
  content((-35pt,55pt), text(black, $1$))
  content((-35pt,-55pt), text(black, $n$))
  content((0,0), text(black, $G$))}))

][
#place(top + center,
  dx: 0pt,
  dy: -120pt,
  canvas({
  import draw: *
  edge((0,7),(2,7))
  edge((1,7),(1,8))
  edge((1,8),(0,9))
  edge((1,8),(2,9))
  edge((1,10),(0,9))
  edge((1,10),(2,9))
  vertex((0,7),"1",white)
  vertex((1,7),"2",blue)
  vertex((2,7),"3",white)
  vertex((1,8),"4",blue)
  vertex((0,9),"5",blue)
  vertex((2,9),"6",blue)
  vertex((1,10),"7",blue)
  content((2.8,7.2), text(black,"......"))
  content((-0.8,7.2), text(black,"......"))

  edge((-0.5,0),(2.5,0))
  edge((0.5,0),(0.5,4))
  edge((1.5,0),(1.5,4))
  edge((-0.5,4),(2.5,4))
  vertex((-0.5,0),"1",white)
  vertex((0.5,0),"2",blue)
  vertex((1.5,0),"3",blue)
  vertex((2.5,0),"4",white)
  vertex((0.5,2),"5",blue)
  vertex((1.5,2),"6",blue)
  vertex((-0.5,4),"7",white)
  vertex((0.5,4),"8",blue)
  vertex((1.5,4),"9",blue)
  vertex((2.5,4),"10",white)
  content((-1.3,0.2), text(black,"......"))
  content((3.3,0.2), text(black,"......"))
  content((-1.3,4.2), text(black,"......"))
  content((3.3,4.2), text(black,"......"))}))
]

== Solve the S-Matrix

Suppose a graph $G$ is the scattering center.
The sites on tails are denoted as $|x,j angle.r$, where $x in RR ^+, 1 <= j <= n$.
For the vertices with attachments, they can also be denoted as $|0,j angle.r$.
The Hamiltonian should be sum of three terms
$ H = H_G + sum_(1 <= j <= n) (T_j + |0,j angle.r angle.l 1,j| + |1,j angle.r angle.l 0,j|) $

The solution of time-independent #text("Schrödinger", lang: "de") equation gives

#place(right+bottom, dx: -86pt, dy: -100pt)[#rect(width: 320pt,height: 32pt,fill: aqua, radius: 10%)]

$ H|"sc"_q (k) angle.r = 2 cos k |"sc"_q (k)angle.r arrow.r.double S_(q j) = (1-z^2) angle.l 0,q| AA^(-1)(z)|0,q angle.r - delta_(q j), $

$ z = e^(i k), AA(z) = II-z H_G + z^2 QQ, QQ = II-sum_(1 <= j <= n) |0,j angle.r angle.l 0,j|. $

#align(right)[
  #text("For detailed proof, see Appendix A.", size: 12pt)
]

= S-Matrices and Universal Gate Set

== Dual-Rail Encode

For a scattering device with 4 tails.
Two of the tails are chosen as input, the other two are chosen as output.

#place(center, dx: -180pt, dy: 0pt)[#canvas({
  import draw: *
  content((0,5),$|0 angle.r " intput:"$)
  rect((4,0),(7,3),radius: 10%)
  content((5.5,1.5),text($U$,size: 24pt))
  line((4,0.5),(0,0.5))
  line((4,2.5),(0,2.5))
  line((7,0.5),(8,0.5))
  line((7,2.5),(8,2.5))

  content((-1,0.5),"1")
  content((-1,2.5),"2")
  content((9,0.5),"3")
  content((9,2.5),"4")

  for i in range(0,38, step: 3) {
      circle((i/10,0.5), radius:2pt, fill: black)
      circle((i/10,2.5), radius:2pt, fill: black)
    }
  for i in range(3,10, step: 3) {
    circle((7+i/10,0.5), radius:2pt, fill: black)
    circle((7+i/10,2.5), radius:2pt, fill: black)
  }

  catmull((1,0.7),(1.2,0.8),(1.3,1.4),(1.5,1.2),(1.7,1.3),(1.8,0.8),(2,0.7),tension: .5,stroke: blue)
  line((1,1.6),(2,1.6),mark:(end:">"))
  content((0.6,1.6),$k$)
})]

#place(center, dx: 160pt, dy: 0pt)[#canvas({
  import draw: *
  content((0,5),$|1 angle.r " intput:"$)
  rect((4,0),(7,3),radius: 10%)
  content((5.5,1.5),text($U$,size: 24pt))
  line((4,0.5),(0,0.5))
  line((4,2.5),(0,2.5))
  line((7,0.5),(8,0.5))
  line((7,2.5),(8,2.5))

  content((-1,0.5),"1")
  content((-1,2.5),"2")
  content((9,0.5),"3")
  content((9,2.5),"4")

  for i in range(0,38, step: 3) {
    circle((i/10,0.5), radius:2pt, fill: black)
    circle((i/10,2.5), radius:2pt, fill: black)
  }
  for i in range(3,10, step: 3) {
    circle((7+i/10,0.5), radius:2pt, fill: black)
    circle((7+i/10,2.5), radius:2pt, fill: black)
  }
  
  catmull((1,2.7),(1.2,2.8),(1.3,3.4),(1.5,3.2),(1.7,3.3),(1.8,2.8),(2,2.7),tension: .5,stroke: red)
  line((1,3.6),(2,3.6),mark:(end:">"))
  content((0.6,3.6),$k$)
})]

#v(180pt)
If there is no scattered component between input tails/output tails,
then the device can be served as a single-qubit gate.

== S-Matrix and Unitary Operator

Under the above mentioned condition,

$ S = mat(0,0,a^*,c^*;0,0,b^*,d^*;a,b,0,0;c,d,0,0) = mat(0,U^dagger;U,0) $

#place(center, dx: 109pt, dy: 64pt)[
  #rect(width: 185pt, height: 70pt, fill: aqua, radius: 10%)
]

By definition of S-matrix, the state after scattering is

$ mat(macron(psi)_(1);macron(psi)_(2);macron(psi)_(3);macron(psi)_(4))
 = mat(0,0,a^*,c^*;0,0,b^*,d^*;a,b,0,0;c,d,0,0)mat(psi_(1);psi_(2);psi_(3)=0;psi_(4)=0)
 arrow.r.double mat(macron(psi)_(3);macron(psi)_(4)) = mat(a,b;c,d) mat(psi_(1);psi_(2)),
 mat(macron(psi)_(1);macron(psi)_(2)) = 0 $

== Basis Change Gate

#place(top,dy: 80pt)[$ k&=pi/4\ S &= mat(0,0,1/ sqrt(2),-i/ sqrt(2);
                     0,0,-i/ sqrt(2), 1/ sqrt(2);
                     1/ sqrt(2),i/ sqrt(2),0,0;
                     i/ sqrt(2),1/ sqrt(2),0,0) $]

#place(bottom + left,
  dx: 250pt,
  dy: -34pt,
  image("change_0_in_population.gif", height: 35%)
)

#place(top + left,
  dx: 400pt,
  dy: 150pt,
  canvas({
  import draw: *
  edge((0,0),(3,0))
  edge((1,0),(1,4))
  edge((2,0),(2,4))
  edge((0,4),(3,4))
  vertex((0,0),"1",white)
  content((0,0.5), text(black,"2"))
  vertex((1,0),"2",blue)
  vertex((2,0),"3",blue)
  vertex((3,0),"4",white)
  content((3,0.5), text(black,"4"))
  vertex((1,2),"5",blue)
  vertex((2,2),"6",blue)
  vertex((0,4),"7",white)
  content((0,4.5), text(black,"1"))
  vertex((1,4),"8",blue)
  vertex((2,4),"9",blue)
  vertex((3,4),"10",white)
  content((3,4.5), text(black,"3"))
})
)

#place(top + right,
  dx: -102pt,
  dy: 62pt,
  image("change_1_out_population.gif", height: 35%)
)

#place(top + right,
  dx: 0pt,
  dy: 90pt,
  image("change_1_out_phase.gif", width: 15%)
)

#place(bottom + right,
  dx: -102pt,
  dy: -32pt,
  image("change_0_out_population.gif", height: 35%)
)

#place(bottom + right,
  dx: 0pt,
  dy: -30pt,
  image("change_0_out_phase.gif", width: 15%)
)

== Phase Gate


#place(top,dy: 80pt)[$ k&=pi/4\ S &= mat(0,0,1,0;
                     0,0,0,e^(-i pi/4);
                     1,0,0,0;
                     0,e^(i pi/4),0,0) $]

#place(bottom + left,
  dx: 240pt,
  dy: -34pt,
  image("phase_0_in_population.gif", height: 35%)
)

#place(top + left,
  dx: 240pt,
  dy: 62pt,
  image("phase_0_in_population.gif", height: 35%)
)

#place(bottom + left,
  dx: 390pt,
  dy: -33pt,
  canvas({
  import draw: *
  edge((-0.5,7),(2.5,7))
  edge((1,7),(1,8))
  edge((1,8),(0,9))
  edge((1,8),(2,9))
  edge((1,10),(0,9))
  edge((1,10),(2,9))
  edge((-0.5,11),(2.5,11))
  vertex((-0.5,7),"1",white)
  content((-0.5,7.5),text(black,"2"))
  vertex((1,7),"2",blue)
  vertex((2.5,7),"3",white)
  content((2.5,7.5),text(black,"4"))
  vertex((1,8),"4",blue)
  vertex((0,9),"5",blue)
  vertex((2,9),"6",blue)
  vertex((1,10),"7",blue)
  vertex((-0.5,11),"8",white)
  content((-0.5,11.5),text(black,"1"))
  vertex((0.5,11),"8",blue)
  vertex((1.5,11),"8",blue)
  vertex((2.5,11),"8",white)
  content((2.5,11.5),text(black,"3"))
})
)

#place(top + right,
  dx: -112pt,
  dy: 62pt,
  image("phase_1_out_population.gif", height: 35%)
)

#place(top + right,
  dx: 0pt,
  dy: 90pt,
  image("phase_1_out_phase.gif", width: 15%)
)

#place(bottom + right,
  dx: -112pt,
  dy: -32pt,
  image("phase_0_out_population.gif", height: 35%)
)

#place(bottom + right,
  dx: 0pt,
  dy: -30pt,
  image("phase_0_out_phase.gif", width: 15%)
)

== Two Qubit Gate: Controlled Phase Gate

Introduce one ancilla qubit (mediator qubit).
$ "CP"_(i j)|a_i, b_j, 0_m angle.r &= "CNOT"_(i m)"CP"_(j m)"CNOT"_(i m)|a_i, b_j, 0_m angle.r\
&= "H"_m "CP"^2_(i m) "H"_m "CP"_(j m) "H"_m "CP"^2_(i m) "H"_m |a_i, b_j, 0_m angle.r $

// #{
//   import "@preview/quill:0.3.0": *

//   quantum-circuit(
//     lstick($|0〉$), $H$, ctrl(1), rstick($(|00〉+|11〉)/√2$, n: 2), [\ ],
//     lstick($|0〉$), 1, targ(), 1
//   )
// }

Thus, gates needed to build universal computer are:
#rect([
  + single-qubit gates on computational qubits ($checkmark$) ,
  + controlled phase gate between computational qubit and mediator qubit,
  + Hadamard gate on mediator qubit.], fill: aqua, inset: 10pt, radius: 10%)

Note: only when the mediator qubit and computational qubit have different momentum,
can they gain non-trivial phase after interaction.

== Hadamard Gate

#place(top,dy: 40pt)[$ k&=pi/2\ S &= mat(0,0,1/sqrt(2),1/sqrt(2);
                     0,0,1/sqrt(2),-1/sqrt(2);
                     1/sqrt(2),1/sqrt(2),0,0;
                     1/sqrt(2),-1/sqrt(2),0,0) $]


#place(bottom + left,
  dx: 260pt,
  dy: -110pt,
  image("hadamard_1_in_population.gif", height: 35%)
)

#place(bottom + left,
  dx: 412pt,
  dy: -110pt,
  canvas({
  import draw: *
  catmull((-1,4),(-0.5,3.9),(0.5,3.1),(1,3),stroke: (paint: orange, dash: "dashed"),tension: .5)
  line((-1,0),(0,0), stroke: (paint: orange, dash: "dashed"))
  catmull((1,1),(2.2,1.4),(2.4,3.6),(3,4),stroke: (paint: orange, dash: "dashed"),tesion: .5)
  catmull((2,4),(2.4,3.6),(2.6,0.5),(3,0),stroke: (paint: orange, dash: "dashed"),tesion: .5)

  edge((0,0),(2,0))
  edge((0,0),(0,4))
  edge((2,0),(2,4))
  edge((0,4),(2,4))
  edge((0,2),(2,2))
  edge((2,0),(0,4))
  edge((1,3),(2,4))
  edge((1,3),(2,2))
  edge((1,3),(0.75,2.75))
  edge((0,2),(0.58,2.58))
  edge((1,1),(0,0))
  edge((1,1),(0,2))
  edge((1,1),(1.25,1.25))
  edge((1.42,1.42),(2,2))
  
  vertex((0,0),"12",blue)
  vertex((2,0),"13",blue)
  vertex((1,1),"11",blue)
  vertex((0,2),"8",blue)
  vertex((1,2),"9",blue)
  vertex((2,2),"10",blue)
  vertex((1,3),"7",blue)
  vertex((0,4),"5",blue)
  vertex((2,4),"6",blue)
  vertex((-1,0),"2",white)
  vertex((-1,4),"1",white)
  vertex((3,0),"4",white)
  vertex((3,4),"3",white)
  content((-1,4.5),text(black,"1"))
  content((-1,0.5),text(black,"2"))
  content((3,4.5),text(black,"3"))
  content((3,0.5),text(black,"4"))
})
)

#place(top + right,
  dx: -60pt,
  dy: -15pt,
  image("hadamard_1_out_population.gif", height: 35%)
)

#place(top + right,
  dx: 40pt,
  dy: 13pt,
  image("hadamard_1_out_phase.gif", width: 15%)
)

#place(bottom + right,
  dx: -60pt,
  dy: -109pt,
  image("hadamard_0_out_population.gif", height: 35%)
)

#place(bottom + right,
  dx: 40pt,
  dy: -107pt,
  image("hadamard_0_out_phase.gif", width: 15%)
)

#place(left+bottom, dx: 160pt, dy: 20pt)[#rect([
  + single-qubit gates on computational qubits ($checkmark$) ,
  + controlled phase gate between computational qubit and mediator qubit,
  + Hadamard gate on mediator qubit ($checkmark$) .], fill: aqua, inset: 10pt, radius: 10%)]

== Two Interacting Bosonic Walker on Infinite Chain

For Bose-Hubbard interaction

$ U(r) = u delta_(r,0), $

the phase gained is

$ e^(i theta) = - frac(u+4i cos ell sin k, u-4i cos ell sin k), ell = frac(p_1+p_2,2), k = frac(p_1-p_2,2) $


#align(right)[
#text("For detailed proof, see Appendix B.", size: 12pt)]

== Momentum Switch

#place(bottom + left,
  dx: 0pt,
  dy: -175pt,
  canvas({
  import draw: *
  edge((0,0),(2,0))
  edge((0,1),(3,1))
  edge((1,0),(1,1))
  edge((2,-1),(2,2))
  edge((2,2),(1.5,3))
  edge((2,2),(2.5,3))
  edge((2,-1),(1.5,-2))
  edge((2,-1),(2.5,-2))
  
  vertex((0,0),"12",white)
  vertex((1,0),"13",blue)
  vertex((2,0),"11",blue)
  vertex((0,1),"8",white)
  vertex((1,1),"9",blue)
  vertex((2,1),"10",blue)
  vertex((3,1),"7",white)
  vertex((2,-1),"5",blue)
  vertex((1.5,-2),"6",blue)
  vertex((2.5,-2),"2",blue)
  vertex((2,2),"1",blue)
  vertex((1.5,3),"4",blue)
  vertex((2.5,3),"3",blue)
  content((-0.5,1),text(black,"1"))
  content((3.5,1),text(black,"2"))
  content((-0.5,0),text(black,"3"))

  circle((-6,0.5),radius: 1)
  edge((-6,-0.5),(-7,0.5))
  edge((-6,-0.55),(-5,0.45))
  edge((-6,-0.45),(-5,0.55))
  vertex((-6,-0.5),"1",white)
  vertex((-5,0.5),"1",white)
  vertex((-7,0.5),"1",white)
  content((-7.5,0.5),"1")
  content((-4.5,0.5),"2")
  content((-6,-1),"3")
  
})
)

#place(bottom + left,
  dx: 0pt,
  dy: 30pt)[#align(left)[Momentum switch is a gadget that leads wave

   with different momentum to different rail.
   
   For $k=pi/4$, perfect transmission happens only 
   
   between 1 and 3.
   
      
   For $k=pi/2$, perfect transmission happens only 
   
   between 2 and 3.]]

#place(top + right,
  dx: -205pt,
  dy: 36pt,
  canvas({
  import draw: *
  circle((-6,0.5),radius: 1)
  edge((-6,-0.5),(-7,0.5))
  edge((-6,-0.55),(-5,0.45))
  edge((-6,-0.45),(-5,0.55))
  vertex((-6,-0.5),"1",white)
  vertex((-5,0.5),"1",white)
  vertex((-7,0.5),"1",white)
  
})
)
#place(top + right,
  dx: -151pt,
  dy: 97pt,
  image("switch_pi4_3_population.gif", width: 12%)
)
#place(top + right,
  dx: -270pt,
  dy: -16pt,
  image("switch_pi4_1_population.gif", width: 12%)
)
#place(top + right,
  dx: -115pt,
  dy: -16pt,
  image("switch_pi4_2_population.gif", width: 12%)
)
#place(top + right,
  dx: 30pt,
  dy: 16pt,
  image("swich_pi4_1_phase.gif", width: 18%)
)




#place(top + right,
  dx: -205pt,
  dy: 206pt,
  canvas({
  import draw: *
  circle((-6,0.5),radius: 1)
  edge((-6,-0.5),(-7,0.5))
  edge((-6,-0.55),(-5,0.45))
  edge((-6,-0.45),(-5,0.55))
  vertex((-6,-0.5),"1",white)
  vertex((-5,0.5),"1",white)
  vertex((-7,0.5),"1",white)
  
})
)
#place(top + right,
  dx: -151pt,
  dy: 267pt,
  image("switch_pi2_3_population.gif", width: 12%)
)
#place(top + right,
  dx: -270pt,
  dy: 154pt,
  image("switch_pi2_1_population.gif", width: 12%)
)
#place(top + right,
  dx: -115pt,
  dy: 154pt,
  image("switch_pi2_2_population.gif", width: 12%)
)
#place(top + right,
  dx: 30pt,
  dy: 184pt,
  image("swich_pi2_2_phase.gif", width: 18%)
)
== C-Phase Gate

#place(top + left,
  dx: 136pt,
  dy: -16pt,
  image("cp_comp_in.gif", height: 50%)
)
#place(bottom + left,
  dx: 0pt,
  dy: 16pt,
  image("cp_medi_in.gif", height: 50%)
)

#place(bottom + left,
  dx: 376pt,
  dy: 16pt,
  image("cp_comp_out.gif", height: 50%)
)
#place(top + left,
  dx: 376pt,
  dy: -16pt,
  image("cp_medi_out.gif", height: 50%)
)

#place(bottom + right,
  dx: 0pt,
  dy: 16pt,
  image("cp_phase.gif", height: 50%)
)

#place(bottom + left,
  dx: 340pt,
  dy: -23pt,
  image("cp_inter.gif", height: 40%)
)

#place(top + right,
  dx: -372pt,
  dy: 110pt,
  canvas({
  import draw: *
  circle((-6,0.5),radius: 1)
  edge((-6,-0.5),(-7,0.5))
  edge((-6,-0.55),(-5,0.45))
  edge((-6,-0.45),(-5,0.55))
  vertex((-6,-0.5),"1",white)
  vertex((-5,0.5),"1",white)
  vertex((-7,0.5),"1",white)
  
})
)
#place(bottom + right,
  dx: -372pt,
  dy: 36pt,
  canvas({
  import draw: *
  circle((-6,0.5),radius: 1)
  edge((-6,1.55),(-7,0.55))
  edge((-6,1.45),(-7,0.45))
  edge((-6,1.5),(-5,0.5))
  vertex((-6,1.5),"1",white)
  vertex((-5,0.5),"1",white)
  vertex((-7,0.5),"1",white)
  
})
)

= Graph Editing and Quantum Circuits

== Link Two Gadget
// #place(top, dy: 30pt)[
// For two scattering setup, $G_1$ and $G_2$.
// The process of connecting them can be formulated as:]

#place(center, dx: -270pt, dy: 40pt,canvas({
  import draw: *
  rect((0,0),(2,4), radius: 10%)
  line((-1,0.5),(-3,0.5))
  line((-1,1.5),(-3,1.5))
  line((-1,2.5),(-3,2.5))
  line((-1,3.5),(-3,3.5))

  for i in (1, 2, 3, 4) {
    for j in (1, 2, 3, 4) {
      line((-1,i - 0.5),(0,j - 0.5))
    }
  }

  content((1,2),text(black,$G_1$))

  vertex((-1,0.5),"1",white)
  vertex((-1,1.5),"1",white)
  vertex((-1,2.5),"1",white)
  vertex((-1,3.5),"1",white)

  vertex((-2,0.5),"1",blue)
  vertex((-2,1.5),"1",blue)
  vertex((-2,2.5),"1",blue)
  vertex((-2,3.5),"1",blue)

  vertex((-3,0.5),"1",blue)
  vertex((-3,1.5),"1",blue)
  vertex((-3,2.5),"1",blue)
  vertex((-3,3.5),"1",blue)

  content((-3.5,0.7),text("..."))
  content((-3.5,1.7),text("..."))
  content((-3.5,2.7),text("..."))
  content((-3.5,3.7),text("..."))

  content((-4.5,0.5),text($1^((1))_("out")$,size: 13pt))
  content((-4.5,1.5),text($0^((1))_("out")$,size: 13pt))
  content((-4.5,2.5),text($1^((1))_("in")$,size: 13pt))
  content((-4.5,3.5),text($0^((1))_("in")$,size: 13pt))
}))

#place(center, dx: -270pt, dy: 170pt,canvas({
  import draw: *
  rect((0,0),(2,4), radius: 10%)
  line((-1,0.5),(-3,0.5))
  line((-1,1.5),(-3,1.5))
  line((-1,2.5),(-3,2.5))
  line((-1,3.5),(-3,3.5))

  for i in (1, 2, 3, 4) {
    for j in (1, 2, 3, 4) {
      line((-1,i - 0.5),(0,j - 0.5))
    }
  }

  content((1,2),text(black,$G_2$))

  vertex((-1,0.5),"1",white)
  vertex((-1,1.5),"1",white)
  vertex((-1,2.5),"1",white)
  vertex((-1,3.5),"1",white)

  vertex((-2,0.5),"1",blue)
  vertex((-2,1.5),"1",blue)
  vertex((-2,2.5),"1",blue)
  vertex((-2,3.5),"1",blue)

  vertex((-3,0.5),"1",blue)
  vertex((-3,1.5),"1",blue)
  vertex((-3,2.5),"1",blue)
  vertex((-3,3.5),"1",blue)

  content((-3.5,0.7),text("..."))
  content((-3.5,1.7),text("..."))
  content((-3.5,2.7),text("..."))
  content((-3.5,3.7),text("..."))

  content((-4.5,0.5),text($1^((2))_("out")$,size: 13pt))
  content((-4.5,1.5),text($0^((2))_("out")$,size: 13pt))
  content((-4.5,2.5),text($1^((2))_("in")$,size: 13pt))
  content((-4.5,3.5),text($0^((2))_("in")$,size: 13pt))
}))

#place(center, dx: 0pt, dy: 40pt,canvas({
  import draw: *
  rect((0,0),(2,4), radius: 10%)
  line((-1,2.5),(-3,2.5))
  line((-1,3.5),(-3,3.5))

  for i in (1, 2, 3, 4) {
    for j in (1, 2, 3, 4) {
      line((-1,i - 0.5),(0,j - 0.5))
    }
  }

  content((1,2),text(black,$G_1$))

  vertex((-1,0.5),"1",white)
  vertex((-1,1.5),"1",white)
  vertex((-1,2.5),"1",white)
  vertex((-1,3.5),"1",white)

  vertex((-2,2.5),"1",blue)
  vertex((-2,3.5),"1",blue)

  vertex((-3,2.5),"1",blue)
  vertex((-3,3.5),"1",blue)

  content((-3.5,2.7),text("..."))
  content((-3.5,3.7),text("..."))

  content((-4.5,2.5),text($1^((1))_("in")$,size: 13pt))
  content((-4.5,3.5),text($0^((1))_("in")$,size: 13pt))
}))

#place(center, dx: 0pt, dy: 170pt,canvas({
  import draw: *
  rect((0,0),(2,4), radius: 10%)
  line((-1,0.5),(-3,0.5))
  line((-1,1.5),(-3,1.5))

  for i in (1, 2, 3, 4) {
    for j in (1, 2, 3, 4) {
      line((-1,i - 0.5),(0,j - 0.5))
    }
  }

  content((1,2),text(black,$G_2$))

  vertex((-1,0.5),"1",white)
  vertex((-1,1.5),"1",white)
  vertex((-1,2.5),"1",white)
  vertex((-1,3.5),"1",white)

  vertex((-2,0.5),"1",blue)
  vertex((-2,1.5),"1",blue)

  vertex((-3,0.5),"1",blue)
  vertex((-3,1.5),"1",blue)

  content((-3.5,0.7),text("..."))
  content((-3.5,1.7),text("..."))

  content((-4.5,0.5),text($1^((2))_("out")$,size: 13pt))
  content((-4.5,1.5),text($0^((2))_("out")$,size: 13pt))
}))

#place(center, dx: 260pt, dy: 110pt,canvas({
  import draw: *
  catmull((0,0),(-1.3,1.3),(0,2.6),tension: .4)
  catmull((0,-1),(-1.3,0.3),(0,1.6),tension: .4)
}))

#place(center, dx: 270pt, dy: 40pt,canvas({
  import draw: *
  rect((0,0),(2,4), radius: 10%)
  line((-1,2.5),(-3,2.5))
  line((-1,3.5),(-3,3.5))

  for i in (1, 2, 3, 4) {
    for j in (1, 2, 3, 4) {
      line((-1,i - 0.5),(0,j - 0.5))
    }
  }

  content((1,2),text(black,$G_1$))

  vertex((-1,0.5),"1",white)
  vertex((-1,1.5),"1",white)
  vertex((-1,2.5),"1",white)
  vertex((-1,3.5),"1",white)

  vertex((-2,2.5),"1",blue)
  vertex((-2,3.5),"1",blue)

  vertex((-3,2.5),"1",blue)
  vertex((-3,3.5),"1",blue)

  content((-3.5,2.7),text("..."))
  content((-3.5,3.7),text("..."))

  content((-4.5,2.5),text($1^((1))_("in")$,size: 13pt))
  content((-4.5,3.5),text($0^((1))_("in")$,size: 13pt))
}))

#place(center, dx: 270pt, dy: 170pt,canvas({
  import draw: *
  rect((0,0),(2,4), radius: 10%)
  line((-1,0.5),(-3,0.5))
  line((-1,1.5),(-3,1.5))

  for i in (1, 2, 3, 4) {
    for j in (1, 2, 3, 4) {
      line((-1,i - 0.5),(0,j - 0.5))
    }
  }

  content((1,2),text(black,$G_2$))

  vertex((-1,0.5),"1",white)
  vertex((-1,1.5),"1",white)
  vertex((-1,2.5),"1",white)
  vertex((-1,3.5),"1",white)

  vertex((-2,0.5),"1",blue)
  vertex((-2,1.5),"1",blue)

  vertex((-3,0.5),"1",blue)
  vertex((-3,1.5),"1",blue)

  content((-3.5,0.7),text("..."))
  content((-3.5,1.7),text("..."))

  content((-4.5,0.5),text($1^((2))_("out")$,size: 13pt))
  content((-4.5,1.5),text($0^((2))_("out")$,size: 13pt))
}))

#place(center, dx: -120pt, dy: 140pt)[#text(red,$arrow.r.double$, size: 48pt)]
#place(center, dx: +150pt, dy: 140pt)[#text(red,$arrow.r.double$, size: 48pt)]

== Link Two Gadget: Abstraction

// #place(top+left, dy: 0pt)[
// The connect process can be abstracted as:]

#place(center, dx: -200pt, dy: 20pt,canvas({
  import draw: *
  rect((0,0),(2,4), radius: 10%)
  line((-1,0.5),(-3,0.5))
  line((-1,1.5),(-3,1.5))
  line((-1,2.5),(-3,2.5))
  line((-1,3.5),(-3,3.5))

  line((3,1),(5,1))
  line((3,2),(5,2))
  line((3,3),(5,3))

  for i in (1, 2, 3, 4) {
    for j in (1, 2, 3, 4) {
      line((-1,i - 0.5),(0,j - 0.5))
    }
  }

  for i in (1, 2, 3) {
    for j in (1, 2, 3) {
      line((3,i),(2,j))
    }
  }

  content((1,2),text(black,$G$))

  vertex((-1,0.5),"1",white)
  vertex((-1,1.5),"1",white)
  vertex((-1,2.5),"1",white)
  vertex((-1,3.5),"1",white)

  vertex((3,1),"1",white)
  vertex((3,2),"1",white)
  vertex((3,3),"1",white)

  vertex((-2,0.5),"1",blue)
  vertex((-2,1.5),"1",blue)
  vertex((-2,2.5),"1",blue)
  vertex((-2,3.5),"1",blue)

  vertex((-3,0.5),"1",blue)
  vertex((-3,1.5),"1",blue)
  vertex((-3,2.5),"1",blue)
  vertex((-3,3.5),"1",blue)

  vertex((4,1),"1",blue)
  vertex((4,2),"1",blue)
  vertex((4,3),"1",blue)

  vertex((5,1),"1",blue)
  vertex((5,2),"1",blue)
  vertex((5,3),"1",blue)

  content((-3.5,0.7),text("..."))
  content((-3.5,1.7),text("..."))
  content((-3.5,2.7),text("..."))
  content((-3.5,3.7),text("..."))

  content((5.5,1.2),text("..."))
  content((5.5,2.2),text("..."))
  content((5.5,3.2),text("..."))

  content((-5,0.5),text($n-k$,size: 16pt))
  content((-4.5,1.5),text($dots.v$,size: 16pt))
  content((-4.5,2.5),text($dots.v$,size: 16pt))
  content((-4.5,3.5),text($1$,size: 16pt))

  content((6.5,1),text($n$,size: 16pt))
  content((6.5,2),text($dots.v$,size: 16pt))
  content((7.5,3),text($n-k+1$,size: 16pt))
}))

#place(center, dx: 0pt, dy: 220pt,canvas({
  import draw: *
  rect((0,0),(2,4), radius: 10%)
  line((-1,0.5),(-3,0.5))
  line((-1,1.5),(-3,1.5))
  line((-1,2.5),(-3,2.5))
  line((-1,3.5),(-3,3.5))

  catmull((3,1),(3.5,1.5),(3,2),tension: .4,stroke: (dash: "dotted"))
  catmull((3,2),(3.5,2.5),(3,3),tension: .4)
  catmull((3,1),(3.5,0.8),(4.5,2),(3.5,3.2),(3,3),tension: .5)

  for i in (1, 2, 3, 4) {
    for j in (1, 2, 3, 4) {
      line((-1,i - 0.5),(0,j - 0.5))
    }
  }

  for i in (1, 2, 3) {
    for j in (1, 2, 3) {
      line((3,i),(2,j))
    }
  }

  content((1,2),text(black,$G$))

  vertex((-1,0.5),"1",white)
  vertex((-1,1.5),"1",white)
  vertex((-1,2.5),"1",white)
  vertex((-1,3.5),"1",white)

  vertex((3,1),"1",white)
  vertex((3,2),"1",white)
  vertex((3,3),"1",white)

  vertex((-2,0.5),"1",blue)
  vertex((-2,1.5),"1",blue)
  vertex((-2,2.5),"1",blue)
  vertex((-2,3.5),"1",blue)

  vertex((-3,0.5),"1",blue)
  vertex((-3,1.5),"1",blue)
  vertex((-3,2.5),"1",blue)
  vertex((-3,3.5),"1",blue)

  content((-3.5,0.7),text("..."))
  content((-3.5,1.7),text("..."))
  content((-3.5,2.7),text("..."))
  content((-3.5,3.7),text("..."))

  content((-5,0.5),text($n-k$,size: 16pt))
  content((-4.5,1.5),text($dots.v$,size: 16pt))
  content((-4.5,2.5),text($dots.v$,size: 16pt))
  content((-4.5,3.5),text($1$,size: 16pt))
}))

#place(center, dx: 220pt, dy: 20pt,canvas({
  import draw: *
  rect((0,0),(2,4), radius: 10%)
  line((-1,0.5),(-3,0.5))
  line((-1,1.5),(-3,1.5))
  line((-1,2.5),(-3,2.5))
  line((-1,3.5),(-3,3.5))

  for i in (1, 2, 3, 4) {
    for j in (1, 2, 3, 4) {
      line((-1,i - 0.5),(0,j - 0.5))
    }
  }

  for i in (1, 2, 3) {
    for j in (1, 2, 3) {
      line((3,i),(2,j))
    }
  }

  content((1,2),text(black,$G$))

  vertex((-1,0.5),"1",white)
  vertex((-1,1.5),"1",white)
  vertex((-1,2.5),"1",white)
  vertex((-1,3.5),"1",white)

  vertex((3,1),"1",white)
  vertex((3,2),"1",white)
  vertex((3,3),"1",white)

  vertex((-2,0.5),"1",blue)
  vertex((-2,1.5),"1",blue)
  vertex((-2,2.5),"1",blue)
  vertex((-2,3.5),"1",blue)

  vertex((-3,0.5),"1",blue)
  vertex((-3,1.5),"1",blue)
  vertex((-3,2.5),"1",blue)
  vertex((-3,3.5),"1",blue)

  content((-3.5,0.7),text("..."))
  content((-3.5,1.7),text("..."))
  content((-3.5,2.7),text("..."))
  content((-3.5,3.7),text("..."))

  content((-5,0.5),text($n-k$,size: 16pt))
  content((-4.5,1.5),text($dots.v$,size: 16pt))
  content((-4.5,2.5),text($dots.v$,size: 16pt))
  content((-4.5,3.5),text($1$,size: 16pt))
}))

#place(center, dx: 40pt, dy: 60pt)[#text(red,$arrow.r.double$, size: 48pt)]

#place(center, dx: 80pt, dy: 160pt)[#rotate(135deg)[#text(red,$arrow.r.double$, size: 48pt)]]

== Link Two Gadget: Calculation

The above operation results in the change of Hamiltonian $H_G$ and $QQ$ matrix.
$ tilde(H)_G = H_G + sum_((alpha,beta) in tilde(E)) |alpha angle.r angle.l beta|+|beta angle.r angle.l alpha| =: H_G +h_G\
 tilde(QQ) = II - sum_(j in "remained")|0,j angle.r angle.l 0,j| = QQ + sum_(j in "cutted")|0,j angle.r angle.l 0,j| =: QQ + Q\
 arrow.r.double tilde(AA)(z) = II - z tilde(H)_G + z^2 tilde(QQ) = AA(z)+z^2 Q - z h_G =:AA(z)+P $

== Link Two Gadget: Result

#place(center, dx: 20pt, dy: 175pt)[
#rect(width: 290pt, height: 32pt, fill: aqua, radius: 10%)]

Suppose the original $S$-matrix, in block form, is
$ S = mat(T_((n-k) times (n-k)), U_((n-k) times k); V_(k times (n-k)), W_(k times k)) $
$ tilde(S) &= (1-z^2)mat(II_n 0)tilde(AA)^(-1)(z)mat(II_n;0) - II_n\
&= T - U P [(1-z^2)II + P + W P]^(-1) V $

For two scattering gates, the above formula gives
$ S_1=mat(0,U_1^dagger;U_1,0), S_2=mat(0,U_2^dagger;U_2,0) arrow.r.double 
 S = mat(0,z^* U_2^dagger U_1^dagger;z U_1 U_2,0) $

= Summary

== Summary

#slide(composer: (1fr, 1fr))[
  About A.M. Childs' construction:
  + no time-dependent quantum controll
  + error bound $tilde O(L^(-1/4))$
  + numerous sites
][
  Future work:
  + delay gadget
  + gadget cascade
  + realization in bio-systems (polymers)
]

==

Thank you

= Appendix A

== Solve the S-Matrix: take a guess!

The eigen-state of Hamiltonian can be expressed as
$ |"sc"_q (k) angle.r = limits(sum)_(v) alpha_(q,v) |v angle.r + limits(sum)_(1 <= j <= n)limits(sum)_(x >= 1) beta_(x,q,j) |x,j angle.r. $
Recall the quantum scattering page, here we take
$ beta_(x,q,j) = angle.l x,j| "sc"_q (k) angle.r = delta_(q j)e^(-i k x) + S_(q j)e^(i k x) $

#v(50pt)
(Actually, suppose this relation holds for all $x>=0$.
Because $|0,j angle.r$ is also a part of path graph.)

== Quantum Scattering (Re-visit)

#slide(composer: (1.2fr, 0.8fr))[
Due to superposition principle, the scattered state may be a superposition of states on different "trajectories".

$ psi_("in")(k) = e^(- i omega t) e^(-i k x ), 
psi_("out")(k) = e^(- i omega t) sum_(k') S_(k k') e^(i k' x) , $
$ psi_("sc")(k) = e^(- i omega t) (delta_(k k') e^(-i k x )+sum_(k') S_(k k') e^(i k' x)) $

The S-matrix is vital to scattering problem.
The orthonormality of $psi_"sc" (k)$ proves the unitarity of S-matrix.
][

#image("quantum.gif")

]

== Solve the S-Matrix: for sites on tails
#align(center)[#rect(
$ |"sc"_q (k) angle.r &= limits(sum)_(v) alpha_(q,v) |v angle.r + limits(sum)_(1 <= j <= n)limits(sum)_(x >= 1) (delta_(q j)e^(-i k x)|x,j angle.r + S_(q j)e^(i k x) |x,j angle.r)\
&= |"sc"_q (k) angle.r^G + limits(sum)_(1 <= j <= n)limits(sum)_(x >= 1) (delta_(q j)e^(-i k x) + S_(q j)e^(i k x) )|x,j angle.r $, fill: silver, radius: 10%)]

Use the result of free propagation, we have
//$ angle.l x',q'|"sc"_q (k) angle.r = delta_(q q')e^(-i k x') + S_(q q')e^(i k x') $

$ angle.l x',q'|H|"sc"_q (k) angle.r &= angle.l x',q'|T_q'|"sc"_q (k) angle.r\
&= angle.l x',q'|2 cos k|"sc"_q (k) angle.r. $

Since $|"sc"_q (k) angle.r$ is an energy eigen-state,
#align(center)[#rect($ H|"sc"_q (k) angle.r = 2 cos k|"sc"_q (k) angle.r $, fill: aqua, radius: 10%)]

== Solve the S-Matrix

#align(center)[#rect($ H = H_G + sum_(1 <= j <= n) (T_j + |0,j angle.r angle.l 1,j| + |1,j angle.r angle.l 0,j|)\ 
 |"sc"_q (k) angle.r = |"sc"_q (k) angle.r^G + limits(sum)_(1 <= j <= n)limits(sum)_(x >= 1) (delta_(q j)e^(-i k x) + S_(q j)e^(i k x) )|x,j angle.r\
 H|"sc"_q (k) angle.r = 2 cos k|"sc"_q (k) angle.r $, fill: silver, radius: 10%)]

$ H|"sc"_q (k) angle.r = &H_G|"sc"_q (k) angle.r^G + \
&sum_(1 <= j <= n)(2 cos k sum_(x>=1)(delta_(q j)e^(-i k x) + S_(q j)e^(i k x) )|x,j angle.r - (delta_(q j)+S_(q j))|1,j angle.r)\
&+ sum_(1 <= j <= n) (|1,j angle.r angle.l 0,j|"sc"_q (k) angle.r^G + |0,j angle.r angle.l 1,j|(delta_(q j) e^(-i k) + S_(q j) e^(i k))|1,j angle.r) = 2 cos k|"sc"_q (k) angle.r  $

== Solve the S-Matrix

$ (H_G-2 cos k)|"sc"_q (k) angle.r^G + sum_(1 <= j <= n)(delta_(q j) e^(-i k) + S_(q j) e^(i k))|0,j angle.r = sum_(1 <= j <= n)(delta_(q j)+S_(q j)-angle.l 0,j|"sc"_q (k) angle.r^G)|1,j angle.r $

#align(center)[#rect($ arrow.r.double S_(q j) = angle.l 0,j|"sc"_q (k) angle.r^G - delta_(q j)  $, fill: aqua, radius: 10%)]

$ (H_G-2 cos k)|"sc"_q (k) angle.r^G+ sum_(1 <= j <= n) (delta_(q j) e^(-i k) - delta_(q j) e^(i k) + e^(i k) angle.l 0,j|"sc"_q (k) angle.r)|0,j angle.r = 0 $

$ (H_G-2 cos k)|"sc"_q (k) angle.r^G + (e^(-i k)-e^(i k))|0,q angle.r + sum_(1 <= j <= n) e^(i k)|0,j angle.r angle.l 0,j|"sc"_q (k) angle.r = 0 $

#align(center)[#rect($ (H_G-2 cos k + e^(i k) sum_(1 <= j <= n) |0,j angle.r angle.l 0,j|)|"sc"_q (k) angle.r^G = (e^(i k)-e^(-i k))|0,q angle.r $, fill: aqua, radius: 10%)]

== Solve the S-Matrix

Denote $z=e^(i k)$ and get

$ AA(z)|"sc"_q (k) angle.r^G = (II-z H_G + z^2 QQ)|"sc"_q (k) angle.r^G = (1 - z^2)|0,q angle.r , QQ = II-sum_(1 <= j <= n) |0,j angle.r angle.l 0,j|. $

Then

$ S_(q j) = (1-z^2) angle.l 0,q| AA^(-1)(z)|0,q angle.r - delta_(q j) $

= Appendix B

== Two Interacting Walkers in Free Space

The coordinates of two bosons are denoted as $x,y$.

Then the sites of the system are

$ |x,y angle.r = |x angle.r times.circle |y angle.r . $

#text(
"Note that exchange symmetry is not considered here.
But it will be considered are the very end of the proof.", size: 16pt
)

The Hamiltonian is, under this "basis",

$ H = sum_(x,y) (&|x+1,y angle.r angle.l x,y|+|x,y angle.r angle.l x+1,y|+\
&|x,y+1 angle.r angle.l x,y|+|x,y angle.r angle.l x,y+1|+U(|x-y|)|x,y angle.r angle.l x,y|) $

== Basis Transformation

Consider a set of new coordinates $s=x+y,r=x-y$, the Hamiltonian can be expressed as

$ H &= sum_(s,r) (|s+1,r+1 angle.r angle.l s,r| + |s,r angle.r angle.l s+1,r+1|+\
&|s+1,r-1 angle.r angle.l s,r|+|s,r angle.r angle.l s+1,r-1|+U(|r|)|s,r angle.r angle.l s,r|)\
&= sum_(s,r) (|s+1 angle.r angle.l s| times.circle |r+1 angle.r angle.l r| + |s angle.r angle.l s+1| times.circle |r angle.r angle.l r+1| +\
&|s+1 angle.r angle.l s| times.circle |r-1 angle.r angle.l r| + |s angle.r angle.l s+1| times.circle |r angle.r angle.l r-1|+U(|r|)|s angle.r angle.l s| times.circle |r angle.r angle.l r|)\
&= H_("free")^((s)) times.circle H_("free")^((r)) + II^((s)) times.circle sum_(r) U(|r|)|r angle.r angle.l r| \
&=: F_s times.circle F_r + II_s times.circle U_r $

== Eigen-State

Notice that $s$-part Hamiltonian is just free particle.

$ angle.l s,r|"cr"(ell,k)angle.r = e^(-i ell s) angle.l r| psi_r (ell, k) angle.r $

Assume the interaction $U(|r|)$ is of range $C$, i.e., $U(|r|)=0$ for $|r|>C$.

So for $|r|>C$, the $r$-part Hamiltonian is also free particle.

$ angle.l r|psi_r (ell,k) angle.r = e^(-i k r) + alpha(ell,k) e^(i k r) , " for " r< -C\
angle.l r|psi_r (ell,k) angle.r = beta(ell,k) e^(-i k r), " for " r> C $

Again, for $|r|>C$

$ angle.l s,r|H|"cr"(ell,k)angle.r &= angle.l s,r|F_s times.circle F_r|"cr"(ell,k)angle.r\
&=4 cos ell cos k angle.l s,r|"cr"(ell,k)angle.r $

== Time-Independent Schrödinger Equation

The eigen-state, plugged in konwn information, is of the form

$ |psi_r (ell,k) angle.r = sum_(-C <= r <= C) phi_r |r angle.r
 + sum_(r< -C) (e^(-i k r) + alpha(ell,k) e^(i k r))|r angle.r +
  sum_(r> C) beta(ell,k) e^(-i k r)|r angle.r\
  |"cr"(ell,k) angle.r = |"pl"(ell) angle.r times.circle |psi_r (ell,k) angle.r $

Consider the Schrödinger equation for eigen-state $|"cr"(ell,k) angle.r$,

$ H|"cr"(ell,k) angle.r = 2 cos ell|"pl"(ell) angle.r times.circle F_r|psi_r (ell,k) angle.r + |"pl"(ell) angle.r times.circle U_r|psi_r (ell,k) angle.r = 4 cos ell cos k|"cr"(ell,k) angle.r\ \ \ 
arrow.r.double 2 cos ell F_r|psi_r (ell,k) angle.r + U_r|psi_r (ell,k) angle.r = 4 cos ell cos k|psi_k (ell,k) angle.r  $

== Exchange Symmetry

By swapping the particle coordinates $x$ and $y$, we have

$ "Sym"(|x,y angle.r) &= frac(1,sqrt(2))(|x,y angle.r plus.minus |y,x angle.r) \
&=frac(1,sqrt(2))(|s,r angle.r plus.minus |s,-r angle.r) \ 
& = |s angle.r times.circle "Sym"(|r angle.r). $

As for the eigen-state, we have

$ |psi_(-r) (ell,k) angle.r = sum_(-C <= r <= C) phi_(-r) |r angle.r
 + sum_(r> C) (e^(i k r) + alpha(ell,k) e^(-i k r))|r angle.r +
  sum_(r< -C) beta(ell,k) e^(i k r)|r angle.r = |psi_r (ell,-k) angle.r $

is another eigen-state with same energy ($E=4 cos ell cos k$ is even in $k$).

== Exchange Symmetry: Continued

The "true" eigen-state that satisfies exchange symmetry is

$ "Sym"(|psi_r (ell,k) angle.r) = &frac(1,sqrt(2)) sum_(-C <= r <= C) ( phi_r plus.minus phi_(-r)) |r angle.r+\
  &frac(1,sqrt(2))sum_(r> C) [e^(i k r) + (alpha plus.minus beta) e^(-i k r)]|r angle.r +
  frac(1,sqrt(2))sum_(r< -C) [e^(-i k r) + (alpha plus.minus beta) e^(i k r)]|r angle.r. $

Clearly, the phase gained through interaction is

$ e^(i theta) = alpha(ell,k) plus.minus beta(ell,k). $

== Bose-Hubbard Model

For Bose-Hubbard model, $U(r)=u delta_(r,0)$, $C=0$.

$ |psi_r (ell,k) angle.r = phi_0 |0 angle.r
 + sum_(r< 0) (e^(-i k r) + alpha(ell,k) e^(i k r))|r angle.r +
  sum_(r> 0) beta(ell,k) e^(-i k r)|r angle.r $

And the Schrödinger equation gives

$ 2 cos ell [phi_0|1 angle.r + phi_0|-1 angle.r + (e^(i k)+alpha(ell,k) e^(i k))|0 angle.r - (1+ alpha)|-1 angle.r + beta e^(-i k)|0 angle.r - beta |1 angle.r]\
 + u phi_0|0 angle.r = 4 cos ell cos k phi_0 |0 angle.r\ \ $

 #place(center, dx: -160pt)[
 $ phi_0 &= 1+ alpha \ phi_0 &= beta \ u phi_0 &= 4i cos ell sin k (phi_0 -1) $]

 #place(center, dx: 160pt, dy: 25pt)[
 $ arrow.r.double e^(i theta) = frac(4i cos ell sin k +u, 4i cos ell sin k -u) $]