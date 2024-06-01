import yt_dlp
import playsound

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
    file_path = download_audio(url)
    playsound.playsound(file_path, False)

def stop_audio():
    playsound.playsound('', False)
