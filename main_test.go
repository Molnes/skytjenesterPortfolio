package main

import (
	"net/http"
	"testing"
)

func TestGreet(t *testing.T) {
	// set up a server that closes when the test is done
	go func() {
		http.HandleFunc("/", greet)
		http.ListenAndServe(":8080", nil)

	}()

	req, err := http.NewRequest("GET", "http://localhost:8080/", nil)
	if err != nil {
		t.Fatal(err)
	}

	// create a client and send the request
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		t.Fatal(err)
	}

	// check the response
	if resp.StatusCode != http.StatusOK {
		t.Errorf("Status should be 200, got %d", resp.StatusCode)
	}

	// check the body contains the right content
	expected := "<html><body>"
	buf := make([]byte, len(expected))
	n, err := resp.Body.Read(buf)
	if err != nil {
		t.Fatal(err)
	}
	// check if the the expected string is contained in the body
	if string(buf[:n]) != expected {
		t.Errorf("Expected %s, got %s", expected, string(buf[:n]))
	}

}
