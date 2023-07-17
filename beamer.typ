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
    header: align(right, image(uestc_logo_path,width: 25%))
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
  )
  set outline(
      title: none,
      depth: 2,
      indent: 2em,
      fill: none
  )
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
    header: locate(loc => {
      let title = query(heading.where(level:1).before(loc),loc).last().body
      grid(
        rows:(70%, 10%),
        row-gutter: 0%,
        grid(
          columns:(25%, 75%),
          align(left+horizon, image(uestc_logo_path, width:100%)),
          align(center+horizon, text(fill: uestc_blue, size: 25pt, weight: "bold", title))
        ),
        align(center+bottom, line(length: 100%, stroke: (paint:uestc_blue, thickness:1pt)))
      )
    })
  )

  show heading.where(level:1):it => {
    set page(
      margin: (top:5%, bottom: 5%, left: 5%, right:5%),
      fill: uestc_ginkgo,
      header: none, 
      background: none
    )
    align(center+horizon, text(fill: white, size: 40pt, it))
  }

  show heading.where(level:2): it => {
    locate( loc => {
      let level_1_now_title = query(heading.where(level:1).before(loc),loc).last().body
      let level_2_now_title = query(heading.where(level:2).before(loc),loc).last().body
    
      let first_title = none
      let get = false
      for item in query(heading.where(level:1).or(heading.where(level:2)),loc) {
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
    })
    align(top, text(size: 20pt, it))
    v(1em)
  }
  body
}

#let beamer_end() = {
  set page(fill: uestc_blue)
  set align(left+horizon)
  text(40pt, weight: "bold", fill: white )[End of Beamer!]
}

#let beamer( title:none, subtitle:none, author:none, date:datetime(year: 2023, month: 7, day: 15), body) = {
  set page(
    paper: "presentation-16-9",
  )
  set text(font: "TeX Gyre Bonum", size:18pt, weight: "regular")
  beamer_start(title:title, author:author, date:date)
  beamer_catalogs()
  beamer_content(body)
  beamer_end()
}