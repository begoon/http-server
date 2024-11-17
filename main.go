package main

import (
	"encoding/json"
	"net/http"
)

func main() {
	http.HandleFunc("GET /version", func(w http.ResponseWriter, r *http.Request) {
		version := struct {
			Version string `json:"version"`
		}{Version: "1.0.0"}
		if err := json.NewEncoder(w).Encode(version); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		return
	})
	http.ListenAndServe(":8000", nil)
}
