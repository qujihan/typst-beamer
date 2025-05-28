#import "../beamer.typ": beamer
#import "@preview/mitex:0.2.5": *
#set math.equation(numbering: "(1)")

#let my_today = datetime.today().display()

#show: beamer.with(
  title: text(size: 28pt)[A Review of Lensless Imaging ] + "\n" + text(size: 25pt)[New Paradigm in Computational Imaging],
  author: "\n\n" + text(size: 20pt)[QJY] + "\n\n" + text(size: 20pt)[UESTC · student num · Collage],
  date: my_today,
)

= What is lensless imaging?
== One-sentence introduction

#v(0.5em)
#text(size: 28pt)[A lensless camera is a camera without a lens!]
#v(-1.9em)
#figure(
  image(width: 65%, "无透镜是什么.png"),
  caption: [This image shows the appearance of a lensless camera.#cite(<li2024lensless>)]
)

== Lens-based Camera vs. Lensless Camera
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 2pt + black)
  } else {
    (bottom: 1pt + black)
  },
  inset: 12pt,
)
#set text(size:15pt)
#figure(
  table(
    columns: 3, align: left,

    // 表头
    table.header(
      [*Aspect*], 
      [*Lens-based*], 
      [*Lensless*],
    ),

    // 各维度行数据
    // [成像原理], [使用镜头聚焦成像], [通过掩模编码光线、由算法重建],
    // [体积与重量], [厚重、体积大], [超薄、轻量化],
    // [集成能力], [难以集成在芯片中], [易于芯片级集成],
    // [图像质量决定因素], [依赖镜头光学质量], [依赖重建算法性能],
    // [系统灵活性], [受限于视场角与分辨率权衡], [依赖算法，可灵活调节],
    // [高维数据采集], [多维信息需多次采集,耗时], [可压缩编码，单次采集],
    // [制造成本], [光学系统复杂，成本高], [掩模简单，成本低],
    [Imaging Principle], [Lens focus], [Mask + algorithm],
    [Size], [Thick & heavy], [Thin & light],
    [Cost], [High], [Low],
    [Integration on-chip], [Impossible], [Possible],
    [Image Quality], [Depends on lens], [Depends on reconstruction algorithm],
    // [Flexibility], [Limited], [Flexible],
    [High-dimensional Imaging], [Multiple shots], [One shot],
  ),
  // caption: figure.caption(
  //   position: top,
  //   [lensless camera compared with traditional imaging.]
  // )
)
#set text(size:18pt)
== Applications of Lensless Cameras
#show figure.caption: it => [
  #set text(size: 10pt)
  #it.supplement
  #context it.counter.display(it.numbering)
  #it.separator
  #set text(size: 10pt)
  #it.body
]
#set text(size:12pt)
#v(-1.5em)
#box(height: 320pt,width: 600pt,
  columns(2, gutter: 30pt)[
    *Microscopic imaging*
    #v(-0.7em)
    #line(length: 100%, stroke: (paint: black, thickness: 1pt))
    #v(-0.7em)
    #figure(
      image(height: 9em, "应用 1.png"),
      caption: [Brain tissue imaging via SUSHI microscopy#cite(<tonnesen2018super>)]
    )
    #v(-0.2em)
    * Multispectral imaging*
    #v(-0.7em)
    #line(length: 100%, stroke: (paint: black, thickness: 1pt))
    #v(-0.7em)
    #figure(
      image(height: 9em, "应用 2.png"),
      caption: [Snapshot hyperspectral imaging with Spectral DiffuserCam#cite(<monakhova2020spectral>).]
    )
   #colbreak()
    *3D imaging*
    #v(-0.7em)
    #line(length: 100%, stroke: (paint: black, thickness: 1pt))
    #v(-0.7em)
    #figure(
      image(height: 9em, "应用 3.png"),
      caption: [Single-shot 3D imaging using DiffuserCam#cite(<antipa2017diffusercam>).]
    )
    #v(-0.2em)
    *Optical fiber imaging*
    #v(-0.7em)
    #line(length: 100%, stroke: (paint: black, thickness: 1pt))
    #v(-0.7em)
    #figure(
      image(height: 9em, "应用 4.png"),
      caption: [Lensless microendoscopy via masked optical fiber#cite(<shin2019minimally>).]
    )
  ]
)
#set text(size:18pt)
#show figure.caption: it => [
  #set text(size: 16pt)
  #it.supplement
  #context it.counter.display(it.numbering)
  #it.separator
  #set text(size: 16pt)
  #it.body
]
= How does a lensless camera work?

== System Architecture
#counter(page).update(4)
#figure(
  image(width: 90%, "框架.png"),
  caption: [Overview of a typical lensless imaging system#cite(<li2024lensless>).]
)
== Hardware (Encoding Optics)
#show figure.caption: it => [
  #set text(size: 12pt)
  #it.supplement
  #context it.counter.display(it.numbering)
  #it.separator
  #set text(size: 12pt)
  #it.body
]
#set text(size:16pt)
#v(-0.5em)
#box(height: 300pt, width: 700pt,
  columns(2, gutter: 30pt)[
    *Introduction*
    #v(-0.7em)
    #line(length: 100%, stroke: (paint: black, thickness: 1pt))
    - Inspired: pinhole imaging  
    - Feature: forms multiplexed patterns  
    #v(1em)
    #figure(
      image(width: 100%, "孔径.png"),
      caption: [Comparison between pinhole and coded aperture imaging#cite(<li2024lensless>).]
    )
  #colbreak()
    *Example*
    #v(-0.7em)
    #line(length: 100%, stroke: (paint: black, thickness: 1pt))
    - Fig a: projection of the mask  
    - Fig b: captured multiplexed measurements  
    #v(1em)
    #figure(
      image(width: 100%, "Snipaste_2025-05-21_19-48-59.png"),
      caption: [Examples of mask projection and sensor measurement#cite(<kuo2017diffusercam>).]
    )
  ]
)
#set text(size:18pt)
#show figure.caption: it => [
  #set text(size: 16pt)
  #it.supplement
  #context it.counter.display(it.numbering)
  #it.separator
  #set text(size: 16pt)
  #it.body
]
== Software (Decoding algorithm)
#show figure.caption: it => [
  #set text(size: 12pt)
  #it.supplement
  #context it.counter.display(it.numbering)
  #it.separator
  #set text(size: 12pt)
  #it.body
]
#set text(size:13pt)
#v(-1.5em)
#box(height: 320pt,width: 700pt,
  columns(2, gutter: 30pt)[
    *Problem Description*
    #v(-0.7em)
    #line(length: 100%, stroke: (paint: black, thickness: 1pt))
    #v(-0.5em)
      - Forward model:
        #mitex(
        ```latex 
        y = A x + n
        ```)
        - $A$: an underdetermined matrix  
        - $n$: noise  
      - Goal: Solve for $x$
    // #v(-0.2em)
    *Method*
    #v(-0.7em)
    #line(length: 100%, stroke: (paint: black, thickness: 1pt))
    #v(-0.5em)
      - Optimization method:
        #mitex(
        ```latex 
          \min_x \| A x - y \|^2 + R(x) 
        ```)
        - Iterative solvers: ISTA, ADMM, FISTA
      - Deep Learning
        #mitex(
        ```latex 
        x = f_\theta(y)
        ```)
        - Models: UNet, Unfold network, Deep noise prior
  #colbreak()
    *Illustration diagram*
    #v(-0.7em)
    #line(length: 100%, stroke: (paint: black, thickness: 1pt))
    #v(-0.5em)
    #figure(
      image(height: 20em, "method.png"),
      caption: [iterative optimization & deep learning-based reconstruction approaches#cite(<li2024lensless>).]
    )
  ]
)
#show figure.caption: it => [
  #set text(size: 16pt)
  #it.supplement
  #context it.counter.display(it.numbering)
  #it.separator
  #set text(size: 16pt)
  #it.body
]
#set text(size:18pt)
= What am I working on?

== Relevance to My Work \.\.\.
#counter(page).update(7)
#set text(size:24pt)
- Focus on lensless image reconstruction.

- Now:

  - Using new models.
  
  - Improve robustness to noise.

  - Build a complete system.
== References
#text(size: 15pt)[
  #bibliography("ref.bib", title: none, style: "ieee")
]