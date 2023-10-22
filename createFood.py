import pygame, sys, json, os, pygame_widgets
import pygame.gfxdraw 
import pygetwindow as gw
from pygame_widgets.slider import Slider
from pygame_widgets.textbox import TextBox
# Class Food
class Food:
    def __init__(self, food, position, density):
        self.food = food
        self.position = position
        self.density = density
    def __str__(self):
        return f"Food: {self.food}, Position: {self.position}, Density: {self.density}"

class FoodManager:
    def __init__(self):
        self.food_cells = []
        
    def load_json(self):
        try:
            with open(path_file + "\\food.json", "r") as json_file:
                json_data = json_file.read()  # Leer todo el contenido del archivo JSON
                if json_data:  # Verificar si el contenido del archivo no está vacío
                    data = json.loads(json_data)
                    for food_entry in data:
                        food = food_entry["food"]
                        position = tuple(food_entry["position"])
                        density = int(food_entry["density"])
                        self.add_food(food, position, density)
                else:
                    print("JSON file is empty.")
        except FileNotFoundError:
            print("No 'food.json' file found.")
        except json.decoder.JSONDecodeError as e:
            print(f"Error decoding JSON: {e}")


           
    def add_food(self, food, position, density):
        new_food = Food(food, position, density)
        if not self.food_exists(position):
            self.food_cells.append(new_food)
        else:
            self.remove_food(position)
            self.add_food(food, position, density)
            
    def remove_food(self, position):
        self.food_cells = [food for food in self.food_cells if food.position != position]
        for food in self.food_cells:
            print(food)
    def food_exists(self, position):
        for food in self.food_cells:
            if food.position == position:
                return True
        return False
        
    def get_food_at_position(self, position):
        for food in self.food_cells:
            if food.position == position:
                return food
        return None

# Class Tool
class Tool:
    def __init__(self, index, name):
        self.index = index
        self.name = name
        self.image = pygame.image.load(path_images + name + ".png")
        self.text = pygame.image.load(path_images + name + "_t.png")
        self.text_border = pygame.image.load(path_images + name + "_tb.png")
        
class ToolManager:
    def __init__(self):
        self.tools = []

    def add_tool(self, name):
        self.tools.append(Tool(len(self.tools), name))
            
    def handle_click(self, event):
        global tool_selected
        x, y = event.pos
        for tool in self.tools:
            rect = pygame.Rect(tool.index * border, 0, border, border)
            if rect.collidepoint(x, y):
                if tool_selected != tool.name:
                    tool_selected = tool.name
                    print(f"Herramienta {tool.index + 1} ({tool.name}) seleccionada.")
                else:
                    tool_selected = ""
                    print(f"Herramienta {tool.index + 1} ({tool.name}) deseleccionada.")
                break

# Funciones
def draw_border():
    pygame.draw.rect(window, background_window, pygame.Rect(0, 0, window_width, border))
    pygame.draw.rect(window, background_window, pygame.Rect(0, window_height - border, window_width, border))
    pygame.draw.rect(window, background_window, pygame.Rect(0, 0, border, window_height))
    pygame.draw.rect(window, background_window, pygame.Rect(window_width - border, 0, border, window_height))
    
def draw_grid():
    gridColor = (180, 25, 25)
    for x in range(border, window_width - border +1, cellSize):
        pygame.draw.line(window, gridColor, (x, border), (x, window_height - border))

    for y in range(border, window_height - border +1, cellSize):
        pygame.draw.line(window, gridColor, (border, y), (window_width - border, y))
        
def draw_cell():
    for cell in food_manager.food_cells:
        cell_x = (cell.position[0] - first_x) * cellSize + border
        cell_y = (cell.position[1] - first_y) * cellSize + border
        if cell_x >= first_x and cell_y >= first_y:
            if value_between(cell_x, border, window_width-border) and value_between(cell_y, border, window_height-border):
                image = pygame.image.load(path_images + cell.food + ".png")
                window.blit(image, (cell_x, cell_y))
                
def draw_tools():
    pygame.draw.rect(window, background_tool_color, background_rect)
    for tool in tool_manager.tools:
        rect = pygame.Rect(tool.index * border, 0, border, border)
        pygame.draw.rect(window, background_tool_color, rect)
        image = tool.image if tool.name == tool_selected else convert_to_gray(tool.image)
        window.blit(image, (tool.index * border, -4))  
        text_image = tool.text if tool_selected != tool.name else tool.text_border
        window.blit(text_image, (tool.index * 40, 0))  
        
def convert_to_gray(image):
    gray_image = image.convert()
    gray_image = gray_image.convert_alpha()  

    for x in range(image.get_width()):
        for y in range(image.get_height()):
            r, g, b, a = image.get_at((x, y))
            gray = int(0.3 * r + 0.59 * g + 0.11 * b) 
            gray_image.set_at((x, y), (gray, gray, gray, a))
    return gray_image
    
def value_between(value, min_value, max_value):
    return min_value <= value <= max_value
        
def get_grid_position(x, y):
    grid_x = (x - border + first_x * cellSize) // cellSize
    grid_y = (y - border + first_y * cellSize) // cellSize
    return grid_x, grid_y
    
def is_window_maximized():
    global window_maximized
    window_title = pygame.display.get_caption()[0]
    window = gw.getWindowsWithTitle(window_title)[0]
    window_maximized = window.isMaximized
    return window.isMaximized
   
def use_tool(food_manager):
    x, y = pygame.mouse.get_pos()
    if value_between(x, border, window_width-border) and value_between(y, border, window_height-border):
        if tool_selected == "eraser":
            grid_x, grid_y = get_grid_position(x, y)
            food_manager.remove_food((grid_x, grid_y))
        elif tool_selected != "":
            grid_x, grid_y = get_grid_position(x, y)
            food_manager.add_food(tool_selected, (grid_x, grid_y), int(slider.getValue()))

# Variables
pygame.init()
title = "Food"
window_width = 1280
window_height = 720
min_width = 800
min_height = 600
background_window = (0, 0, 0)

window = pygame.display.set_mode((window_width, window_height), pygame.RESIZABLE)
pygame.display.set_caption(title)

path_file = os.path.dirname(os.path.abspath(__file__))
path_images = path_file + "\\resources\\images\\"
map_image = pygame.image.load(path_images + "_map.png")

running = True
firstCell = None
food_manager = FoodManager()
food_manager.load_json()
tool_selected = ""

mouse_button_pressed = False
cellSize = 40
border = 40
first_x, first_y = 0, 0
    
tool_manager = ToolManager()
tools_to_add = ["eraser", "wheat", "fly", "blueberries", "rice", "corn"]
for tool in tools_to_add: tool_manager.add_tool(tool)

# Slider
background_tool_color = (100, 100, 100)
background_rect = pygame.Rect(window_width - 280, 0, 280, 40)

slider = Slider(window, window_width - 260, 10, 200, 20, min=1, max=255, step=1, handleColour=(0, 0, 0))
font = pygame.font.Font(None, 24)
slider_text_box = TextBox(window, window_width - 40, 0, 40, 40, fontSize=24, colour=background_tool_color, borderThickness = 0)
slider_text_box.disable()

previous_slider_value = slider.getValue()
slider_text_box.setText(previous_slider_value)


while running:
    if is_window_maximized():
        if first_y > 36: first_y = 36
        if first_x > 53: first_x = 53
    events = pygame.event.get()
    for event in events:
        window_width, window_height = pygame.display.get_surface().get_size()
        if window_width < min_width or window_height < min_height:
            window_width = max(window_width, min_width)
            window_height = max(window_height, min_height)
            pygame.display.set_mode((window_width, window_height), pygame.RESIZABLE)
        elif event.type == pygame.QUIT:
            running = False
        elif event.type == pygame.VIDEORESIZE:
            slider.setX(window_width - 260)
            background_rect.x =window_width - 280
            slider_text_box.setX(window_width - 40)
        elif event.type == pygame.MOUSEBUTTONDOWN:
            x, y = pygame.mouse.get_pos()
            if value_between(x, border, window_width-border) and value_between(y, border, window_height-border):
                mouse_button_pressed = True
                if mouse_button_pressed and tool_selected != "": use_tool(food_manager)
            elif event.button == 1:
                tool_manager.handle_click(event)
        elif event.type == pygame.MOUSEBUTTONUP:
            if event.button == 1:
                mouse_button_pressed = False         
        elif event.type == pygame.KEYDOWN:
            if event.key == pygame.K_ESCAPE:
                running = False   
        else:
            if mouse_button_pressed and tool_selected != "": use_tool(food_manager)
            keys = pygame.key.get_pressed()
            if keys[pygame.K_w]: first_y = max(0, first_y - 1)
            elif keys[pygame.K_s]: first_y = min(36 if is_window_maximized() else 42, first_y + 1)
            elif keys[pygame.K_a]: first_x = max(0, first_x - 1)
            elif keys[pygame.K_d]: first_x = min(53 if is_window_maximized() else 68, first_x + 1)
            
            window.fill(background_window)
            window.blit(map_image, (border, border), (first_x*cellSize, first_y*cellSize, window_width - 2 * border, window_height - 2 * border))   
            
            draw_cell()
            draw_border()
            draw_grid()
            draw_tools()
            
            current_slider_value = slider.getValue()
            if current_slider_value != previous_slider_value:
                slider_text_box.setText(current_slider_value)
                previous_slider_value = current_slider_value

            pygame_widgets.update(events)
            pygame.display.flip()


pygame.quit()

pygame.init()
screen = pygame.display.set_mode((400, 200))
pygame.display.set_caption("Save Food?")

font = pygame.font.Font(None, 20)
text = font.render("Do you want to save the current food?", False, (255, 255, 255))
text_rect = text.get_rect(center=(200, 50))
yes_button = pygame.Rect(100, 100, 100, 50)
no_button = pygame.Rect(200, 100, 100, 50)

save_food = None
while save_food is None:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            save_food = False
        if event.type == pygame.MOUSEBUTTONDOWN:
            if yes_button.collidepoint(event.pos):
                save_food = True
            if no_button.collidepoint(event.pos):
                save_food = False

    pygame.draw.rect(screen, (0, 128, 0), yes_button)
    pygame.draw.rect(screen, (128, 0, 0), no_button)
    screen.blit(text, text_rect)
    yes_text = font.render("Yes", True, (255, 255, 255))
    no_text = font.render("No", True, (255, 255, 255))
    screen.blit(yes_text, (115, 115))
    screen.blit(no_text, (225, 115))

    pygame.display.flip()

pygame.quit()

if save_food:
    food_data = []
    for food in food_manager.food_cells:
        food_data.append({"food": food.food, "position": food.position, "density": food.density})

    if not food_data: food_data = []

    with open(path_file + "\\food.json", "w") as json_file:
        json.dump(food_data, json_file, indent=4)

       
# Quit Pygame
pygame.quit()
sys.exit()
