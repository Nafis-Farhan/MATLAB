clear all;
Fs = 22050; %sampling
%syllable a
disp('Generating Syllable a (rho2=-11)');
[m1 ,s1]=singSyllable(-11.0);
disp('Syllable a generated');
%play the syllable
sound(s1(:,1)*10,Fs);
%syllable b
disp('Generating Syllable b (rho2=-11.8)');
[m2 ,s2]=singSyllable(-11.8);
disp('Syllable c generated');
%play the syllable
sound(s2(:,1)*10,Fs);
%syllable c
disp('Generating Syllable c (rho2=-7.1)');
[m3 ,s3] = singSyllable(-7.1);
disp('Syllable c generated');
%play the syllable
sound(s3(:,1)*10,Fs);
%stich the song up
disp('Stiching the song up a-b-c-c');
song = [ s1(:,1) ;s2(:,1) ;s3(:,1); s3(:,1)];
 
disp('Saving wav file');
%wavwrite(song,Fs,'mindlin2002_song.wav');
disp('Playing wav file');
sound(song*10,Fs);