#!/bin/bash
home_dir='' # TODO is this initialization required for a global?
get_home() {
		home_dir=$(getent passwd $USER | awk -F ':' '{print $6}')/  # TODO the trailing slash
}
get_home
path_to_here='project_bash/' # TODO hard coded dir
full_path=$home_dir$path_to_here
if [ $# -ne 2 ]; then # TODO getopt?
	echo 'bad args, use two args : 1. input gif filename, 2. output mp4 filename'
else
	input_gif_filename=$1
	input_gif_filename=$full_path$input_gif_filename
	output_mp4_filename=$2
	output_mp4_filename=$full_path$output_mp4_filename
	ffmpeg -i "$input_gif_filename" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "$output_mp4_filename"
fi
