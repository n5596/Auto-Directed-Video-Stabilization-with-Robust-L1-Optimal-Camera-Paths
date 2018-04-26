# Auto-Directed-Video-Stabilization-with-Robust-L1-Optimal-Camera-Paths
Implementation of the paper by M. Grundmann

Input : Frames of a shaky video. The frames were obtained by using FFMPEG.

video_stabilizationpart1.m : Computes the transforms between adjacent frames.
video_stabilizationpart2.m : Computes the camera path C(t).
video_stabilizationpart3.m : Optimizes the camera path.
video_stabilizationpart4.m : Finds a transform which will map the original camera path to the optimal one.

Output : Frames of the stabilized video. The frames can be merged to create a video using FFMPEG.
