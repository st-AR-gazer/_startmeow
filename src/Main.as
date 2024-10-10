void Main() {
    InitArrays();
}

void startmeow_loc(const string &in soundID = "", int amount = 1, float delay = -1.0) {
    for (int i = 0; i < amount; i++) {
        startnew(CoroutinePlayMeow(soundID, delay));
    }
}

void CoroutinePlayMeow(const string &in soundID, float delay) {
    string fileToPlay;

    if (soundID == "") {
        fileToPlay = GetRandomMeowSound();
    } else {
        if (!soundID.EndsWith(".wav")) soundID += ".wav";
        fileToPlay = soundID;
    }

    PlayMeowSound(fileToPlay);

    if (delay <= 0) {
        yield();
    } else {
        sleep(delay * 1000);
    }
}

void PlayMeowSound(const string &in file) {
    auto meowsound = Audio::LoadSample(file);
    Audio::Play(meowsound);
}

string GetRandomMeowSound() {
    array<string> sounds = meowPaths;

    return sounds[Math::Rand(0, sounds.Length - 1)];
}