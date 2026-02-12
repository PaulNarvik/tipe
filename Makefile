# --- Répertoires ---
SRCDIR = src
BUILDDIR = build
BINDIR = bin
INCDIR = include

# --- Fichiers source et objets ---
SRC = $(wildcard $(SRCDIR)/*.cpp)
OBJ = $(patsubst $(SRCDIR)/%.cpp, $(BUILDDIR)/%.o, $(SRC))

# --- Exécutable ---
EXEC = $(BINDIR)/main

# --- Compilateur ---
CXX = g++

# --- Options de compilation ---
CXXFLAGS = -Wall -Wextra -Wpedantic -fsanitize=address -std=c++20
# Optionnel : si tes headers GMP sont dans /usr/local/include
# CXXFLAGS += -I/usr/local/include

# --- Bibliothèques à lier ---
LDFLAGS = -lgmp -lgmpxx
# Optionnel : si la lib est dans un dossier non standard
# LDFLAGS += -L/usr/local/lib

# --- Règle principale ---
compile: $(BUILDDIR) $(BINDIR) $(EXEC)

# --- Créer les répertoires ---
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(BINDIR):
	mkdir -p $(BINDIR)

# --- Lier ---
$(EXEC): $(OBJ)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS) -I$(INCDIR)

# --- Compiler ---
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@ -I$(INCDIR)

# --- Nettoyage ---
clean:
	rm -f $(BUILDDIR)/*
	rm -f $(BINDIR)/*

# --- Exécuter ---
run: compile
	@echo -e "==========================================\n"
	@./$(EXEC)

# --- Aide ---
help:
	@echo -e "Options possibles :\n- compile pour compiler\n- clean pour nettoyer\n- run pour compiler puis exécuter"

.PHONY: compile clean run help
