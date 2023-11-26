package main

import (
  "fmt"
  "net/http"
  "time"
)

func greet(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "<html><body><h1>Hello World!</h1><p>Timestamp: %s</p></body></html>", time.Now())
}

func main() {
  http.HandleFunc("/", greet)
  http.ListenAndServe(":8080", nil)
}
