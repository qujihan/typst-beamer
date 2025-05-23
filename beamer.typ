#let uestc_blue = rgb(0,55,155)
#let uestc_ginkgo = rgb(217, 183, 102)
#let uestc_logo_path = "./pic/logo.png"
#let ginkgo_path = "./pic/ginkgo.png"
#let mainbuilding_path = "./pic/mainbuilding.png"

#let page_break_flag = state("page_break_flag",true)

#let beamer_start( title:none, subtitle:none, author:none, date:none) = {
  page(
    margin: (top:20%, bottom: 5%, left: 5%, right:5%),
    background: image(mainbuilding_path),
    header: align(right, image(uestc_logo_path,width: 25%)),
    numbering: none,
  )[
    #if title != none {
      align(center+horizon, text(25pt, weight: "bold", title))
    }
    #if author != none {
      align(center+horizon, text(17pt, weight: "regular", author))
    }
    #if date != none {
      align(right+bottom, text(15pt, date))
    }
  ] 
}


#let beamer_catalogs() = {
  set page(
    margin: (top:0%, bottom: 0%, left: 0%, right:10%),
    numbering: none,
  )
  set outline(
      title: none,
      depth: 2,
      indent: 2em,
  )
  set outline.entry(fill: none)
  show outline.entry.where(level:1): it => {
    v(30pt, weak: true)
    text(fill: uestc_blue.lighten(10%), size: 20pt, weight: "bold",it)
  }
  show outline.entry.where(level:2):it => {
    text(fill: uestc_blue.lighten(20%),size: 15pt, weight: "regular",it)
  }
  grid(
    columns:(35%, 70%),
    column-gutter: 16%,
    align(
      center+horizon, 
      box(
        fill: uestc_blue,
        width: 100%,
        height: 100%,
        text(fill: white, size: 40pt, hyphenate: true, weight: "bold", [Outline])
      ),
    ),
    align(center+horizon, outline())
  )  
}

#let beamer_content(body) = {
  set page(
    margin: (top:20%, bottom: 5%, left: 5%, right:5%),
    background: align(right+bottom, image(ginkgo_path, width: 25%)),
    header: context {
    let title = query(selector(heading.where(level: 1)).before(here())).last().body

    grid(
      rows: (70%, 10%),
      row-gutter: 0%,
      grid(
        columns: (25%, 75%),
        align(left + horizon, image(uestc_logo_path, width: 100%)),
        align(center + horizon, text(fill: uestc_blue, size: 25pt, weight: "bold", title))
      ),
      align(center + bottom, line(length: 100%, stroke: (paint: uestc_blue, thickness: 1pt)))
    )
  }
  )

  show heading.where(level:1):it => {
    set page(
      margin: (top:5%, bottom: 5%, left: 5%, right:5%),
      fill: uestc_ginkgo,
      header: none, 
      background: none,
      numbering: none
    )
    align(center+horizon, text(fill: white, size: 40pt, it))
  }

  let level2-count = state("level2-count", -1)

  show heading.where(level:2): it => {
    level2-count.update(n => n + 1)
    context{
      let count = level2-count.get()
      counter(page).update(count)

      let level_1_now_title = query(selector(heading.where(level: 1)).before(here())).last().body
      let level_2_now_title = query(selector(heading.where(level: 2)).before(here())).last().body
    
      let first_title = none
      let get = false
      for item in query(heading.where(level:1).or(heading.where(level:2))) {
        if get {
          if item.level == 2 {
            first_title = item.body
          }
          break
        } else {
          if item.level == 1 and item.body == level_1_now_title {
            get = true
          }
        }
      }
      
      if first_title != level_2_now_title {
        pagebreak()
      }
    }
    align(top, text(size: 20pt, it))
    v(1em)
  }
  body
}

#let beamer_end() = {
  set page(fill: uestc_blue, numbering: none)
  set align(left+horizon)
  text(40pt, weight: "bold", fill: white )[End of Beamer!]
}

#let beamer( title:none, subtitle:none, author:none, date:datetime(year: 2023, month: 7, day: 15), body) = {
  set page(
    paper: "presentation-16-9",
    number-align: right,
  )
  // set text(font: "TeX Gyre Bonum", size:18pt, weight: "regular")
  set text(font: (
  (name: "Times New Roman", covers: "latin-in-cjk"),
  "STHeiti"
  ), lang: "zh", size:18pt, weight: "regular")

  let colored-numbering(..nums) = {
    let page-num = nums.pos().first()
    place(
    right + bottom,
    dx: -0.45em,
    dy: -1.5em,
    circle(
      radius: 0.6em,
      fill: uestc_ginkgo,
      stroke: none,
      align(center + horizon)[
        #text(
          fill: white,
          weight: "bold",
          size: 14pt
        )[#page-num]
      ]
    )
    )
  }
  set page(numbering: colored-numbering)

  beamer_start(title:title, author:author, date:date)
  beamer_catalogs()
  beamer_content(body)
  beamer_end()
}