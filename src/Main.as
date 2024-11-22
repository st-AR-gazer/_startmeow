array<string> meowPaths;
array<Audio::Sample@> meowSamples;

void Main() {
    InitMeowSounds();
}

void InitMeowSounds() {
    for (int i = 0; i <= 16; i++) {

        string path = "src/MoewSounds/meow" + i + ".wav";

        meowPaths.InsertLast(path);

        auto meowsound = Audio::LoadSample(meowPaths[i]);
        meowSamples.InsertLast(meowsound);
    }
}

void startmeow_loc(const string &in soundID = "", int amount = 1, int delay = -1, float gain = 1) {
    string userdata = soundID + "|" + amount + "|" + delay + "|" + gain;
    startnew(CoroutineFuncUserdataString(CoroutinePlayMeows), userdata);
}

void CoroutinePlayMeows(const string &in userdata) {
    array<string> data = userdata.Split("|");
    string soundID = data[0];
    int amount = Text::ParseInt(data[1]);
    int delay = Text::ParseInt(data[2]);

    for (int i = 0; i < amount; i++) {
        Audio::Sample@ sampleToPlay = null;

        if (soundID == "") {
            @sampleToPlay = GetRandomMeowSample();
        } else {
            int index = GetMeowIndexBySoundID(soundID);
            if (index >= 0 && index < meowSamples.Length) {
                @sampleToPlay = meowSamples[index];
            }
        }

        if (sampleToPlay !is null) {
            PlayMeowSample(sampleToPlay);
        }

        if (delay > 0) {
            sleep(delay * 1000);
        }
    }
}

void PlayMeowSample(Audio::Sample@ sample) {
    if (sample !is null) {
        Audio::Play(sample);
    }
}

Audio::Sample@ GetRandomMeowSample() {
    return meowSamples[Math::Rand(0, meowSamples.Length - 1)];
}

int GetMeowIndexBySoundID(const string &in soundID) {
    if (soundID.StartsWith("meow")) {
        return Text::ParseInt(soundID.SubStr(4)) - 1;
    }
    return -1;
}
