import pygame
import pygetwindow as gw
import sys
import threading
import json

pygame.init()
title = "Paths"
window_width = 1280
window_height = 720

window = pygame.display.set_mode((window_width, window_height), pygame.RESIZABLE)
pygame.display.set_caption(title)

map_image = pygame.image.load("resources\\images\\_map.png")
map_width, map_height = map_image.get_size()
cellSize = 40
border = 20
first_x, first_y = 0, 0

def draw_grid():
    font = pygame.font.Font(None, 24)
    gridColor = (180, 25, 25)
    for x in range(border, window_width - border, cellSize):
        pygame.draw.line(window, gridColor, (x, border), (x, window_height - border))

    for y in range(border, window_height - border, cellSize):
        pygame.draw.line(window, gridColor, (border, y), (window_width - border, y))

def get_grid_position(x, y):
    grid_x = (x - border + first_x * cellSize) // cellSize
    grid_y = (y - border + first_y * cellSize) // cellSize
##    print(f"x: {x} y:{y} |first_x:{first_x} first_y:{first_y} | grid_x:{grid_x} grid_y:{grid_y}")
    return grid_x, grid_y

running = True
waitingForSecondCell = False
firstCell = None
selected_cells = []

try:
    with open("paths.json", "r") as json_file:
        data = json.load(json_file)
        for key in data:
            path_data = data[key]
            selected_cells.append((path_data["casilla1"], path_data["casilla2"]))
except FileNotFoundError:
    print("No 'paths.json' file found.")

selecting = False

def is_window_maximized():
    global window_maximized
    window_title = pygame.display.get_caption()[0]
    window = gw.getWindowsWithTitle(window_title)[0]
    window_maximized = window.isMaximized
    return window.isMaximized

while running:
    if is_window_maximized():
        if first_y > 36: first_y = 36
        if first_x > 53: first_x = 53
    for event in pygame.event.get():
        window_width, window_height = pygame.display.get_surface().get_size()
        if event.type == pygame.QUIT:
            running = False

        if event.type == pygame.MOUSEBUTTONDOWN:
            if event.button == 1:
                x, y = pygame.mouse.get_pos()
                grid_x, grid_y = get_grid_position(x, y)
                if not waitingForSecondCell:
                    firstCell = (grid_x, grid_y)
                    waitingForSecondCell = True
                else:
                    secondCell = (grid_x, grid_y)
                    if (firstCell, secondCell) not in selected_cells and (secondCell, firstCell) not in selected_cells:
                        selected_cells.append((firstCell, secondCell))
                        print(f"path.addPointByGrid({firstCell[0]},{firstCell[1]},{secondCell[0]},{secondCell[1]});")
                    waitingForSecondCell = False
                    firstCell = None
            elif event.button == 3:
                x, y = pygame.mouse.get_pos()
                grid_x, grid_y = get_grid_position(x, y)
                if waitingForSecondCell:
                    waitingForSecondCell = False
                    firstCell = None
                elif (firstCell, (grid_x, grid_y)) in selected_cells:
                    selected_cells.remove((firstCell, (grid_x, grid_y)))
                selecting = False

        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_ESCAPE:
                running = False
                
        elif event.type == pygame.ACTIVEEVENT:
            if event.gain == 1 and event.state == 6:
                print('maximized')
            elif event.gain == 0 and event.state == 6:
                print('minimized')

    keys = pygame.key.get_pressed()
    if not waitingForSecondCell:
        if keys[pygame.K_w]:
            first_y = max(0, first_y - 1)
        if keys[pygame.K_s]:
            first_y = min(36 if is_window_maximized() else 42, first_y + 1)
        if keys[pygame.K_a]:
            first_x = max(0, first_x - 1)
        if keys[pygame.K_d]:
            first_x = min(53 if is_window_maximized() else 68, first_x + 1)
##        print(f"{first_x},{first_y}")
        # 68 42
    window.fill((0, 0, 0))
    window.blit(map_image, (border, border), (first_x*cellSize, first_y*cellSize, window_width - 2 * border, window_height - 2 * border))
    
    draw_grid()

    if waitingForSecondCell:
        waiting_text = f"Waiting for the second cell | Selected cell: ({grid_x}, {grid_y})"
        font = pygame.font.Font(None, 24)
        text = font.render(waiting_text, True, (255, 255, 255))
        text_rect = text.get_rect(center=(window_width // 2, window_height-10))
        window.blit(text, text_rect)

        transparent_surface = pygame.Surface((cellSize, cellSize), pygame.SRCALPHA)
        red_with_alpha = (255, 0, 0, 100)
        pygame.draw.rect(transparent_surface, red_with_alpha, (0, 0, cellSize, cellSize))

        x1 = (firstCell[0] - first_x) * cellSize + border
        y1 = (firstCell[1] - first_y) * cellSize + border
        window.blit(transparent_surface, (x1, y1))

    for cell_pair in selected_cells:
        first_cell = cell_pair[0]
        second_cell = cell_pair[1]

        # Calcula las coordenadas en relación con la vista del mapa actual
        x1 = (first_cell[0] - first_x) * cellSize
        y1 = (first_cell[1] - first_y) * cellSize
        x2 = (second_cell[0] - first_x) * cellSize
        y2 = (second_cell[1] - first_y) * cellSize

        if cell_pair[0][0] >= first_x and cell_pair[0][1] >= first_y:
            if cell_pair[1][0] >= first_x and cell_pair[1][1] >= first_y:
                pygame.draw.line(window, (0, 255, 0), (x1 + border, y1 + border), (x2 + border, y2 + border), 2)
    pygame.display.flip()

if selected_cells:
    pygame.quit()

    save_paths = None
    pygame.init()
    screen = pygame.display.set_mode((400, 200))
    pygame.display.set_caption("Save Paths?")

    font = pygame.font.Font(None, 20)
    text = font.render("Do you want to save the current paths?", False, (255, 255, 255))
    text_rect = text.get_rect(center=(200, 50))
    yes_button = pygame.Rect(100, 100, 100, 50)
    no_button = pygame.Rect(200, 100, 100, 50)

    while save_paths is None:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                save_paths = False
            if event.type == pygame.MOUSEBUTTONDOWN:
                if yes_button.collidepoint(event.pos):
                    save_paths = True
                if no_button.collidepoint(event.pos):
                    save_paths = False

        pygame.draw.rect(screen, (0, 128, 0), yes_button)
        pygame.draw.rect(screen, (128, 0, 0), no_button)
        screen.blit(text, text_rect)
        yes_text = font.render("Yes", True, (255, 255, 255))
        no_text = font.render("No", True, (255, 255, 255))
        screen.blit(yes_text, (115, 115))
        screen.blit(no_text, (225, 115))

        pygame.display.flip()

    pygame.quit()

    if save_paths:
        data = {}
        for i, cell_pair in enumerate(selected_cells):
            key = f"path_{i + 1}"
            data[key] = {"casilla1": cell_pair[0], "casilla2": cell_pair[1]}
        
        with open("paths.json", "w") as json_file:
            json.dump(data, json_file, indent=4)
# Quit Pygame
pygame.quit()
sys.exit()
