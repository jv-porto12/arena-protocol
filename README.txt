--- Arena Protocol ---

***YOUTUBE LINK FOR VIDEO REPORT***:
https://youtu.be/-kbJguMFzjs

Course: INFR 3110U Game Engine Design
Engine: Godot 4.7.2
Language: GD Script
Project Type: Individual, 2D Arena Game prototype
Developer: John-Vincent Porto
Student ID: 100971747
Role: Solo Dev; everything


--- Project Overview ---

Arena Protocol is a top-down, 2D arena prototype developed using design principles discussed in class. The player moves through an arena while enemies of different types spawn and chase the player. Each enemy type has a distinct color, move speed, health value and score amount. 

The prototype includes the 4 primary technical systems. A GameManager Singleton for score tracking, an EnemyFactory for enemy creation, a Command system that supports 'beacon' placement with undo & redo functionality, and a custom WaveSpawner plugin that allows for configurable enemy spawning and difficulty. 

Unfortunately, the project is very bare bones in its current state; The beacons don't have any functionality besides places them down and undo/redo placement, and the core gameplay loop can barely be called gameplay. With that being said, I plan to flesh this out immensely by the end of the semester. 


--- Controls ---

W/A/S/D - Movement
Space - Place beacon
Z - Undo previous beacon
Y - Redo previously undone beacon


--- Singleton Pattern - GameManager ---

The Singleton pattern is implemented using Godot's Autoload system. The GameManager.gd script is registered as an Autoload, creating a single globally accessible manager responsible for shared game data.
Currently, the GameManager manages the player's score. When an enemy collides with the player, it calls GameManager.add_score(). The manager updates the score and emits a score_changed signal. The Main scene receives the signal and updates the HUD.

Diagram is in Diagrams folder and titled "Singleton Diagram"


--- Factory Pattern - EnemyFactory ---

The Factory pattern is used to centralize enemy creation and configuration. The EnemyFactory.gd script contains a create_enemy() method that receives an enemy type and spawn position.
The factory instantiates the base enemy scene and configures its properties using a match statement. Three enemy configurations are currently supported: Normal, Fast, and Tank.
Each type receives different movement speed, score value, and color

Just like the Singleton, the Diagram is in Diagrams folder, but is titled "Factory Diagram" instead.


--- Command Pattern - Beacon Placement --- 

The Command pattern is used to implement reversible beacon placement. The implementation consists of three scripts:

GameCommand.gd, Defines the base command interface, including execute() and undo() methods.
PlaceBeaconCommand.gd, Implements beacon creation and removal. Each command stores the location where its beacon should be placed.
CommandManager.gd, Executes commands and manages two history stacks: an undo stack and a redo stack.

Execution Flow:
When the player presses Space:
Main creates a PlaceBeaconCommand.
The command receives the target position and beacon container.
CommandManager executes the command.
The command creates the beacon.
The command is stored in the undo stack.
The redo stack is cleared.
When the player presses Z, CommandManager removes the latest command from the undo stack, calls its undo() method, and moves it to the redo stack.
When the player presses Y, the most recently undone command is executed again and returned to the undo stack.

Diagram is in the diagram folder and titled "Command Diagram"


--- Custom Plugin - WaveSpawner ---

Arena Protocol includes a custom GDScript-based Godot editor plugin named Arena Wave Spawner. The plugin uses Godot's EditorPlugin interface to register a reusable WaveSpawner node.
The WaveSpawner system handles enemy creation requests, spawn intervals, and progressively increasing difficulty. The node exposes configurable Inspector properties, including:
Starting spawn interval
Minimum spawn interval
Difficulty step
Number of enemies spawned before difficulty increases
Spawn area

Technical Classification: WaveSpawner is a custom GDScript editor plugin, not a native compiled DLL or GDExtension.


--- Project Management and Progression ---

The initial development phase focused on establishing the playable prototype and implementing the required design patterns.

The October 29 checkpoint includes working implementations of Singleton, Factory, Command, and the WaveSpawner editor plugin.

The project is maintained through Git and GitHub, with a standalone Windows build available through GitHub Releases.


Planned Future Development:
The next development phase will focus on improving existing implementations and introducing additional course concepts

--- Development Contributions ---

Developer: John-Vincent (JV) Porto
Student ID: 100971747
Role: Solo developer
Team contribution: 100%

Development responsibilities include:
Project setup and scene configuration
Design-pattern integration
Gameplay scripting and system configuration
Testing and debugging
Enemy appearance customization
Custom plugin integration and configuration
Repository management
Windows export and release verification
Documentation and presentation

Since the project is completed individually, no group task distribution was required. The solo approach was selected to keep the prototype's scope manageable and maintain direct responsibility for integrating and testing its systems.


--- Installation and Execution ---

Standalone Windows Build:
Open the repository's GitHub Releases section.
Download ArenaProtocol-v0.1-Windows.zip.
Extract the archive.
Launch ArenaProtocol.exe.

Source Project:
Clone or download the repository.
Open Godot 4.
Import the project using its project.godot file.
Confirm that the Arena Wave Spawner plugin is enabled.
Run the Main scene using F5.


--- Generative AI Disclosure ---

ChatGPT was used as a development assistant during the project.

AI assistance included:
Brainstorming the project concept and scope
Recommending suitable design-pattern implementations
Generating initial GDScript examples
Assisting with debugging

AI Citation: OpenAI. (2026). ChatGPT [Large language model]. https://chatgpt.com/
Used for interactive development assistance during October 27–29, 2026.


--- Third-Party Resources ---

The project uses Godot Engine and its built-in APIs.

The WaveSpawner plugin was developed using Godot's editor extension API and is not a downloaded third-party plugin.

--- Known Limitations ---

Arena Protocol is currently an architectural prototype rather than a fully developed game.

Current limitations include:
No complete combat system
Enemy-player contact awards score rather than causing damage
Basic enemy movement and collision handling
Beacon placement is a demonstration of reversible commands rather than a complete gameplay mechanic
No completed performance profiling or optimization comparison
These limitations provide clear opportunities for future development while keeping the initial prototype focused on course requirements.
