var background = Elm.worker(Elm.Background, {});

function launch(){
    chrome.app.window.create('gui/gui.html', {
        'outerBounds': {
            'width': 400,
            'height': 500,
        }
    });
}

chrome.app.runtime.onLaunched.addListener(launch);
