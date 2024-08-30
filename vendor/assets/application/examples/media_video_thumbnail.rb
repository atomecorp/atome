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



