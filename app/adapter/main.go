package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/api/health", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		fmt.Fprint(w, `{"status":"healthy","service":"adapter"}`)
	})

	log.Println("adapter listening on :8001")
	log.Fatal(http.ListenAndServe(":8001", nil))
}
