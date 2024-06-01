import yt_dlp
from pydub import AudioSegment
import simpleaudio as sa

current_audio = None

def download_audio(query):
    ydl_opts = {
        'format': 'bestaudio/best',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
        'outtmpl': f'{query}',
    }
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info_dict = ydl.extract_info(f"ytsearch:{query}", download=True)
        file_path = ydl.prepare_filename(info_dict)
    return f'{query}.mp3'

def play_audio(url):
    global current_audio
    if current_audio:
        current_audio.stop()
    file_path = download_audio(url)
    audio = AudioSegment.from_file(file_path)
    current_audio = sa.play_buffer(audio.raw_data, num_channels=audio.channels, bytes_per_sample=audio.sample_width, sample_rate=audio.frame_rate)

def stop_audio():
    global current_audio
    if current_audio:
        current_audio.stop()
        current_audio = None
