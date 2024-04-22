This is my implementation of the classic videogame Breakout as part of the "20 games challenge" exercise. 

I've made it using the Godot engine and I got to learn and exercise patterns and specifics of the engine.

Even though Godot has a garbage collector and the blocks in the game are not so numerous for object pooling to make a significant difference in performance, I wanted to practice using object pooling for the wall blocks instantiation. Object pooling is an important pattern that reduce calls to memory alocation / deallocation and helps to avoid memory fragmentation specially in devices with limited memory.

I've also developed a persistent local highscores screen in this game, that stores the 10 better scores in a locally stored savefile. 

For the player to be able to input their name to the scoreboard using a controller, I've developed a simple virtual keyboard.
