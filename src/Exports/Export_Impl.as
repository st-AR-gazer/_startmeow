void startmeow(const string &in soundID = "", int amount = 1, int delay = -1) {
    startmeow_loc(soundID, amount, delay);
}
void startmeow(const string &in soundID = "", int amount = 1, int delay = -1, float gain = 1) {
    startmeow_loc(soundID, amount, delay, gain);
}
