# Définir les répertoires
SRCDIR = src
BUILDDIR = build
BINDIR = bin
INCDIR = include

# Trouver tous les fichiers source (.c) dans src
SRC = $(wildcard $(SRCDIR)/*.c)

# Générer la liste des fichiers objets (.o) dans build
OBJ = $(patsubst $(SRCDIR)/%.c, $(BUILDDIR)/%.o, $(SRC))

# Nom de l'exécutable (modifiable selon tes besoins)
EXEC = $(BINDIR)/main

# Compilateur
CC = gcc

# Options de compilations
CFLAGS = -Wall -Wextra -Wvla -fsanitize=address

# Règle principale
compile: $(BUILDDIR) $(BINDIR) $(EXEC)

# Créer le répertoire build s'il n'existe pas
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# Créer le répertoire bin s'il n'existe pas
$(BINDIR):
	mkdir -p $(BINDIR)

# Lier les fichiers objets pour créer l'exécutable
$(EXEC): $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@ -I$(INCDIR)

# Compiler chaque fichier source en fichier objet
$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ -I$(INCDIR)

# Nettoyer les fichiers générés
clean:
	rm -f $(BUILDDIR)/*
	rm -f $(BUILDDIR)/*

run:
	@echo -e "==========================================\n"
	@./$(EXEC)

docs: 
	doxygen Doxyfile

help:
	@echo -e "Options possibles :\n- all pour compiler le projet\n- clean pour nettoyer le projet\n- run pour compiler puis exécuter\n- clean_comp pour nettoyer puis compiler\n- clean_run pour nettoyer, compiler puis exécuter"

# Indiquer que clean et run ne sont pas des fichiers
.PHONY: compile clean run docs help
