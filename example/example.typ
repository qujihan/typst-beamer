#import "../beamer.typ": beamer

#show: beamer.with(
  title: "Write a Beamer Template in Typst",
  author: "qujihan@github",
  date: "2023-04-03",
)

= Show Time
== Offical Example Code (Fibonacci sequence)
#lorem(20)
$ F_n = round(1/sqrt(5) phi.alt^n), quad phi.alt = (1 + sqrt(5))/2 $
#let count = 8
#let nums = range(1, count+1)
#let fib(n) = (
  if n <= 2{
    1
  } else {
    fib(n - 1) + fib(n - 2)
  }
)

#align(center+horizon, box(width: 60%,lorem(20)))

#align(center+horizon, table(
  columns: count,
  ..nums.map(n => $F_#n$),
  ..nums.map(n => str(fib(n)))
))


== Pic Example
#align(center + horizon, 
  figure(
    image(width: 50%, "seda.jpg"),
    caption:[My friend photographed Seda in western Sichuan]
  )
)

== Code Example
#columns(2,gutter: 5%)[
  ```golang
    func bubbleSort(arr[] int) []int {
      length := len(arr)
        if length <=1 {
        return arr
      }
      for i :=0;i < length - 1;i++ {
        for j :=0;j < length - i -1;j++ {
          if arr[j+1] > arr[j] {
            arr[j],arr[j+1] = arr[j+1],arr[j]
          }
        } 
      }
      return arr
    }
  ```
  #colbreak()

  Bubble sort is a simple sorting algorithm that repeatedly compares adjacent elements in a sequence and swaps them if they are in the wrong order (ascending or descending). The larger (or smaller) elements gradually "bubble" to the end of the sequence.
]


= Todo
== Footer

#box(width: 90%,text([
There's no support for footer because I can't use it yet, but I'll add it as soon as I can.
]))

== Catalogs
#box(width: 80%,text([
  The part about the implementation of the catalog is too ugly, but the official hasn't provided too many ways to modify the catalog, so I'll leave it like this for now, and wait for future modifications
]))