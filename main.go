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
	fmt.Println("Server started, listening on port http://127.0.0.1:8080.")
	http.ListenAndServe(":8080", nil)
}
