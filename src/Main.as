void Main() {
    InitArrays();
}

array<string> meowPaths;

void InitArrays() {
    for (int i = 1; i <= 17; i++) {
        meowPaths.InsertLast("src/MoewSounds/meow" + i + ".wav");
    }
}

void startmeow_loc(const string &in soundID = "", int amount = 1, int delay = -1) {
    string userdata = soundID + "|" + amount + "|" + delay;
    startnew(CoroutineFuncUserdataString(CoroutinePlayMeows), userdata);
}

void CoroutinePlayMeows(const string &in userdata) {
    array<string> data = userdata.Split("|");
    string soundID = data[0];
    int amount = Text::ParseInt(data[1]);
    int delay = Text::ParseInt(data[2]);

    for (int i = 0; i < amount; i++) {
        string fileToPlay;

        if (soundID == "") {
            fileToPlay = GetRandomMeowSound();
        } else {
            if (!soundID.EndsWith(".wav")) soundID += ".wav";
            fileToPlay = soundID;
        }

        PlayMeowSound(fileToPlay);

        if (delay > 0) {
            sleep(delay * 1000);
        }
    }
}

void PlayMeowSound(const string &in file) {
    auto meowsound = Audio::LoadSample(file);
    Audio::Play(meowsound);
}

string GetRandomMeowSound() {
    return meowPaths[Math::Rand(0, meowPaths.Length - 1)];
}