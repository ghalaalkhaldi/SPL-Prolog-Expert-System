# SPL-Prolog-Expert-System
An AI-powered expert system using Prolog for analyzing the Saudi Professional League.

# Saudi League: Analysis System of the Saudi Football League

## Abstract

This project develops an expert system using Prolog to analyze the Saudi Professional League (SPL). It provides valuable insights for coaches, players, and fans by processing match data and applying logical rules to derive meaningful information. The system leverages Prolog's strength in symbolic reasoning to create an interactive analytical tool.

## Features

The system provides comprehensive analysis capabilities, including:

* **Team Analysis:** Identify teams with the most points, most goals scored, fewest goals conceded, most wins, fewest losses, and most draws.
* **Match Analysis:** Analyze matches based on criteria like most goals scored and fewest goals conceded.
* **Player Analysis:** Determine players with the most goals, most assists, most yellow cards, and most red cards.
* **Interactive Query System:** A user-friendly menu allows users to select specific analyses.

## Technologies Used

* **Prolog:** The core programming language for the expert system.
* **SWI-Prolog:** The development environment used for implementation and execution.

## Dataset

The system's knowledge base is built upon match data from the Saudi Professional League (SPL) for the current season (2023-2024). The data was sourced from the official SPL website (https://www.spl.com.sa/en). The facts derived from this data are stored in `data/spl_facts.pl`.

## How to Run the System

To run this expert system, you will need SWI-Prolog installed on your machine.

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/ghalaalkhaldi/SPL-Prolog-Expert-System.git](https://github.com/ghalaalkhaldi/SPL-Prolog-Expert-System.git)
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd SPL-Prolog-Expert-System
    ```
3.  **Open SWI-Prolog:** Start the SWI-Prolog console.
4.  **Load the main program:** In the SWI-Prolog console, load the `spl_main.pl` file:
    ```prolog
    ?- [src/spl_main].
    ```
    (Make sure you are in the `SPL-Prolog-Expert-System` directory when you launch SWI-Prolog, or provide the full path to `src/spl_main.pl`).
5.  **Start the main menu:** Once loaded, you can run the main menu:
    ```prolog
    ?- main_menu.
    ```
    Follow the on-screen prompts to explore the system's analysis capabilities.

## Project Members

* **Ghala M. Alkhaldi** (Leader) 
* **May M. AlOtaibi** (Member) 
* **Bushra M. Alshehri** (Member) 
* **Jumana Y. Aljassim** (Member) 
* **Fatima A. Alrastem** (Member) 

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
