array<string> meowPaths;

void InitArrays() {
    for (int i = 1; i <= 150; i++) {
        meowPaths.InsertLast("src/MoewSounds/meow" + i + ".wav");
    }
}