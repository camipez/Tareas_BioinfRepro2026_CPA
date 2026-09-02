# Tareas_BioinfRepro2026_CPA

Coursework repository for **Bioinformatics and Reproducible Research for Genomic Analysis**
(*Bioinformática e investigación reproducible para análisis genómicos*), Universidad de Chile, 2026.

## Purpose

This repository stores the assignments of the course, following the reproducible-research
practices taught in it: every analysis is documented in plain-text Markdown, every script is
commented, and the full history of changes is tracked with `git`, so that any reader — including
my future self — can understand what was done, how, and in which order.

## Author

- **Student:** Camila Astorga
- **Professor:** Ricardo Verdugo
- **Institution:** Facultad de Ciencias Químicas y Farmacéuticas, Universidad de Chile

## Repository organisation

One directory per assignment. Each directory contains its own `README.md`, which is the main
report for that assignment, plus one subdirectory per exercise and, where scripts are requested,
a `bin/` directory holding them.

| Directory | Content |
|---|---|
| [`Tarea_1.2/`](Tarea_1.2/) | Unit 1, Session 2 — Organisation of a bioinformatics project: Markdown, `git`/GitHub from the command line, and modularisation of a Stacks pipeline. |

```
Tareas_BioinfRepro2026_CPA/
├── README.md              <- this file
└── Tarea_1.2/
    ├── README.md          <- main report of the assignment
    ├── figuras/           <- figures cited in the report
    ├── ejercicio1/        <- Markdown practice
    ├── ejercicio3/        <- cloning and editing the course repository
    ├── ejercicio5/        <- analysis of the Stacks script
    └── bin/               <- modular pipeline scripts (exercise 6)
```

## How to read this repository

Open the `README.md` inside each assignment directory: it contains the objectives, the methodology
(the actual commands used), the results with their numbered figures, and the conclusions of every
exercise. The files referenced in the report are stored in the subdirectories listed above.

## Source of the assignments

The exercises come from the course repository
[u-genoma/BioinfinvRepro](https://github.com/u-genoma/BioinfinvRepro).
