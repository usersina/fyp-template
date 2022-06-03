package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	fs := http.FileServer(http.Dir("./public"))
	http.Handle("/", fs)

	port := os.Getenv("PORT")
	if port == "" {
		port = "3000" // Default port if not specified
	}
	log.Println("Listening on :" + port)
	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Fatal(err)
	}
}
