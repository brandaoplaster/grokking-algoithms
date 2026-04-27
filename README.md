# Bhargava Algorithms in Ruby

Implementation of algorithms from the book **"Grokking Algorithms"** by **Aditya Bhargava** using Ruby.

## About

This repository contains Ruby implementations of the main algorithms presented in Aditya Bhargava's "Grokking Algorithms" book, covering topics such as:

- Search and sorting algorithms
- Big O notation
- Recursion
- Divide and conquer
- Greedy algorithms
- Dynamic programming

## Project Structure

```
bhargava/
├── cap_1/              # Chapter 1 - Introduction to Algorithms
│   ├── binary_search.rb
│   ├── simple_search.rb
│   └── contacts.json
├── shared/             # Shared code
│   ├── contact.rb
│   └── contact_loader.rb
├── gemfile
└── README.md
```

## Prerequisites

- Ruby 3.0 or higher
- Bundler

## Installation

Clone the repository:

```bash
git clone https://github.com/brandaoplaster/grokking-algoithms.git
cd grokking-algoithms
```

Install dependencies:

```bash
bundle install
```

## Running the Code

### Chapter 1 - Search Algorithms

Run simple search (linear):

```bash
ruby cap_1/simple_search.rb
```

Run binary search:

```bash
ruby cap_1/binary_search.rb
```

Both scripts perform benchmarks comparing algorithm performance across different scenarios using a dataset of 1 million contacts.

## Implemented Algorithms

### Chapter 1 - Introduction to Algorithms

- Simple Search (Linear Search): O(n)
- Binary Search: O(log n)

