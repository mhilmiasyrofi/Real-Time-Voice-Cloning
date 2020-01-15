from pathlib import Path
import librosa
import os

path = "dataset/hilmi_recording.mp3"
in_fpath = os.fspath(Path(path.replace("\"", "").replace("\'", "")))

## Computing the embedding
# First, we load the wav using the function that the speaker encoder provides. This is
# important: there is preprocessing that must be applied.

# The following two methods are equivalent:
# - Directly load from the filepath:
# print("preprocess wav")
# preprocessed_wav = encoder.preprocess_wav(in_fpath)
# - If the wav is already loaded:
print("Load Librosa")
original_wav, sampling_rate = librosa.load(in_fpath)
