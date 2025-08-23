// take these as consts pls
var size = '50x50'
var pixelation_mode = 'k' // icat, you can use timg's pixelation modes, auto not supported atm

function printCover() {
    var path = mp.get_property("path");

    var data = mp.utils.file_info(path);
    var cover_path = '/tmp/mpv-img-have-to-make-tmp.png';
    if(data === undefined) return;

    var ffmpego = mp.command_native({
        name: 'subprocess',
        capture_stdout: false,
        detach: false,
        args: [ 'ffmpeg', '-hide_banner', '-y', '-loglevel', 'quiet', '-i', path, '-an', '-vcodec', 'copy', cover_path ]
    });
    if(ffmpego.status !== 0) return mp.log('debug', 'Couldn\'t cover successfully');

    mp.command_native({
        name: 'subprocess',
        playback_only: true,
        detach: false,
        capture_stdout: false,
        args: [ 'timg', '-p' + pixelation_mode, '-g' + size, cover_path ]
    });
}

mp.register_event("file-loaded", printCover);
