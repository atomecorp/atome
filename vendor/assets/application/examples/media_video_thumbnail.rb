# frozen_string_literal: true


video({id: :video, path: 'medias/videos/avengers.mp4', width: 300, height: 222 })
waveform_container=box({id: 'thumbnails-container', top: 190,width: 666, height: 39, color: :gray})
waveform_container.draw({width: 666, height: 33,  id: :thumbnails})
waveform_container.box({id: 'progress', width: 3, height: '100%', color: :red})


box({id: :file, top: 666, left: 12, width: 300, height: 40, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 } })
box({id: :load_file, top: 777, left: 12, width: 300, height: 40, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 } })


  JS.eval <<~JS

const video = document.getElementById('video');

		const thumbnailsCanvas = document.getElementById('thumbnails');
		const thumbnailsCtx = thumbnailsCanvas.getContext('2d');
		const progress = document.getElementById('progress');
		// const loadFileButton = document.getElementById('load-file');
		// const fileInput = document.getElementById('file-input');
		let isDragging = false;

		// Charger la vidéo par défaut
		video.addEventListener('loadeddata', () => {
			drawThumbnails(12);
		});

		video.addEventListener('timeupdate', () => {
			const progressPosition = (video.currentTime / video.duration) * thumbnailsCanvas.clientWidth;
			progress.style.left = `${progressPosition}px`;
		});

		// Drag and Drop Events
		// loadFileButton.addEventListener('dragover', (event) => {
		// 	event.preventDefault();
		// 	loadFileButton.classList.add('dragover');
		// });
        //
		// loadFileButton.addEventListener('dragleave', () => {
		// 	loadFileButton.classList.remove('dragover');
		// });
        //
		// loadFileButton.addEventListener('drop', (event) => {
		// 	event.preventDefault();
		// 	loadFileButton.classList.remove('dragover');
		// 	const file = event.dataTransfer.files[0];
		// 	if (file && file.type.startsWith('video/')) {
		// 		loadVideoFile(file);
		// 	}
		// });

		// loadFileButton.addEventListener('click', () => {
		// 	fileInput.click();
		// });
        //
		// fileInput.addEventListener('change', (event) => {
		// 	const file = event.target.files[0];
		// 	if (file) {
		// 		loadVideoFile(file);
		// 	}
		// });

		async function loadVideoFile(file) {
			try {
				const objectURL = URL.createObjectURL(file);
				video.src = objectURL;
				video.load(); // Reload the video to apply the new source
			} catch (error) {
				console.error('Error loading video file:', error);
			}
		}

		function drawThumbnails(maxImages) {
			const samples = Math.min(maxImages, maxImages);
			const interval = video.duration / samples;
			const videoAspectRatio = video.videoWidth / video.videoHeight;

			// Adjust the canvas height based on the video's aspect ratio
			const canvasWidth = thumbnailsCanvas.width;
			const canvasHeight = canvasWidth / videoAspectRatio / maxImages;
			thumbnailsCanvas.height = canvasHeight;

			video.pause();
			video.currentTime = 0;

			let i = 0;
			const captureFrames = () => {
				if (i >= samples) return;

				video.currentTime = i * interval;

				video.addEventListener('seeked', function capture() {
					const width = canvasWidth / samples;
					const height = canvasHeight;

					thumbnailsCtx.drawImage(video, i * width, 0, width, height);

					video.removeEventListener('seeked', capture);
					i++;
					captureFrames();
				});
			};
			captureFrames();
		}

		thumbnailsCanvas.addEventListener('mousedown', (event) => {
			video.pause();
			isDragging = true;
			handleScrub(event);
		});

		// Attach mouseup event to the document to ensure it is captured even if mouse leaves the canvas
		document.addEventListener('mouseup', (event) => {
			video.play();
			if (isDragging) {
				isDragging = false;
			}
		});

		thumbnailsCanvas.addEventListener('mousemove', (event) => {
			if (isDragging) {
				handleScrub(event);
			}
		});

		function handleScrub(event) {
			const rect = thumbnailsCanvas.getBoundingClientRect();
			const scrubX = event.clientX - rect.left;
			const newTime = (scrubX / thumbnailsCanvas.clientWidth) * video.duration;
			video.currentTime = newTime;
		}


  JS




def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "3",
    "addEventListener",
    "box",
    "classList",
    "click",
    "clientWidth",
    "clientX",
    "createObjectURL",
    "currentTime",
    "dataTransfer",
    "draw",
    "drawImage",
    "duration",
    "error",
    "eval",
    "getBoundingClientRect",
    "getContext",
    "getElementById",
    "height",
    "left",
    "load",
    "min",
    "mp4",
    "pause",
    "play",
    "preventDefault",
    "removeEventListener",
    "src",
    "style",
    "target",
    "type",
    "videoHeight",
    "videoWidth",
    "width"
  ],
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "addEventListener": {
    "aim": "The `addEventListener` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `addEventListener`."
  },
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "classList": {
    "aim": "The `classList` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `classList`."
  },
  "click": {
    "aim": "The `click` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `click`."
  },
  "clientWidth": {
    "aim": "The `clientWidth` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `clientWidth`."
  },
  "clientX": {
    "aim": "The `clientX` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `clientX`."
  },
  "createObjectURL": {
    "aim": "The `createObjectURL` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `createObjectURL`."
  },
  "currentTime": {
    "aim": "The `currentTime` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `currentTime`."
  },
  "dataTransfer": {
    "aim": "The `dataTransfer` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `dataTransfer`."
  },
  "draw": {
    "aim": "The `draw` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `draw`."
  },
  "drawImage": {
    "aim": "The `drawImage` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `drawImage`."
  },
  "duration": {
    "aim": "The `duration` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `duration`."
  },
  "error": {
    "aim": "The `error` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `error`."
  },
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "getBoundingClientRect": {
    "aim": "The `getBoundingClientRect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getBoundingClientRect`."
  },
  "getContext": {
    "aim": "The `getContext` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getContext`."
  },
  "getElementById": {
    "aim": "The `getElementById` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getElementById`."
  },
  "height": {
    "aim": "The `height` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `height`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "load": {
    "aim": "The `load` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `load`."
  },
  "min": {
    "aim": "The `min` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `min`."
  },
  "mp4": {
    "aim": "The `mp4` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `mp4`."
  },
  "pause": {
    "aim": "The `pause` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `pause`."
  },
  "play": {
    "aim": "The `play` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `play`."
  },
  "preventDefault": {
    "aim": "The `preventDefault` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `preventDefault`."
  },
  "removeEventListener": {
    "aim": "The `removeEventListener` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `removeEventListener`."
  },
  "src": {
    "aim": "The `src` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `src`."
  },
  "style": {
    "aim": "The `style` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `style`."
  },
  "target": {
    "aim": "The `target` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `target`."
  },
  "type": {
    "aim": "The `type` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `type`."
  },
  "videoHeight": {
    "aim": "The `videoHeight` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `videoHeight`."
  },
  "videoWidth": {
    "aim": "The `videoWidth` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `videoWidth`."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
