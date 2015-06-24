% Record your voice for 5 seconds.
% recObj = audiorecorder(8192, 16, 1);
recObj = audiorecorder;         % default is 8000 Hz, 8 BIT, 1 Channel
disp('Start speaking.')
recordblocking(recObj, 5);      % record for 5 sec
disp('End of Recording.');

% Play back the recording.
play(recObj);

% Store data in double-precision array.
myRecording = getaudiodata(recObj);

% Plot the waveform.
plot(myRecording);