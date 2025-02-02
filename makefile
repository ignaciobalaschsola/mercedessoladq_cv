# Define file paths
SRC_DIR = src
BUILD_DIR = build
CLASS_FILE = altacv/altacv.cls
IMG_FILE = profile.jpg

# Compiler and flags
LATEXMK = latexmk
PDFLATEX = pdflatex -interaction=nonstopmode

# Default rule
all: spanish catalan

# Rule for Spanish version
spanish: $(BUILD_DIR)/spanish.pdf

$(BUILD_DIR)/spanish.pdf: $(SRC_DIR)/spanish.tex $(SRC_DIR)/$(CLASS_FILE) $(SRC_DIR)/$(IMG_FILE)
	@mkdir -p $(BUILD_DIR)
	cp $(SRC_DIR)/spanish.tex $(BUILD_DIR)/
	cp $(SRC_DIR)/$(CLASS_FILE) $(BUILD_DIR)/
	cp $(SRC_DIR)/$(IMG_FILE) $(BUILD_DIR)/
	cd $(BUILD_DIR) && $(LATEXMK) -pdf -pdflatex="$(PDFLATEX)" spanish.tex

# Rule for Catalan version
catalan: $(BUILD_DIR)/catalan.pdf

$(BUILD_DIR)/catalan.pdf: $(SRC_DIR)/catalan.tex $(SRC_DIR)/$(CLASS_FILE) $(SRC_DIR)/$(IMG_FILE)
	@mkdir -p $(BUILD_DIR)
	cp $(SRC_DIR)/catalan.tex $(BUILD_DIR)/
	cp $(SRC_DIR)/$(CLASS_FILE) $(BUILD_DIR)/
	cp $(SRC_DIR)/$(IMG_FILE) $(BUILD_DIR)/
	cd $(BUILD_DIR) && $(LATEXMK) -pdf -pdflatex="$(PDFLATEX)" catalan.tex

# Clean up auxiliary files (but keep the PDFs)
clean:
	$(LATEXMK) -c -output-directory=$(BUILD_DIR) $(BUILD_DIR)/spanish.tex $(BUILD_DIR)/catalan.tex
	rm -rf $(BUILD_DIR)/*.log $(BUILD_DIR)/*.aux $(BUILD_DIR)/*.fls $(BUILD_DIR)/*.fdb_latexmk
	rm -rf $(BUILD_DIR)/*.out $(BUILD_DIR)/*.synctex.gz

# Fully remove all generated files
purge: clean
	rm -rf $(BUILD_DIR)

# Open the compiled PDF (Mac/Linux)
view-spanish:
	open $(BUILD_DIR)/spanish.pdf

view-catalan:
	open $(BUILD_DIR)/catalan.pdf
