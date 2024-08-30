# frozen_string_literal: true



audio({id: :audio})
waveform_container=box({id: 'waveform-container', width: 666, height: 270, color: :orange})
waveform_container.draw({width: 666, height: 270,  id: :waveform})
waveform_container.box({id: 'progress', width: 3, height: '100%', color: :red})

draw({width: 666, height: 270, top: 280,color: :orange, id: :realtime})


box({id: :load_file, top: 666, left: 12, width: 300, height: 40, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 } })
box({id: :file_input, top: 777, left: 12, width: 300, height: 40, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 } })


# box({id: :waveform, left: 0})
# box({id: :realtime,  left: 1000})
# box({id: :load_file, left: 200})
# box({id: :file_input, left: 300})
#####<audio id="audio" controls>
# 		Your browser does not support the audio element.
# 	######</audio>
# 	<div id="waveform-container">
# 		<canvas id="waveform" width="600" height="200"></canvas>
# 		<div id="progress"></div>
# 	</div>
#
# 	<!-- <div id="realtime-container"> -->
# 		<canvas id="realtime" width="600" height="200"></canvas>
# 	<!-- </div> -->
#
# 	<button id="load-file">Load Audio File</button>
# 	<input type="file" id="file-input" accept="audio/*">
#
JS.eval <<~JS
const audio = document.getElementById('audio');
		const waveformCanvas = document.getElementById('waveform');
		const waveformCtx = waveformCanvas.getContext('2d');
		const realtimeCanvas = document.getElementById('realtime');
		const realtimeCtx = realtimeCanvas.getContext('2d');
		const progress = document.getElementById('progress');
		const loadFileButton = document.getElementById('load_file');
		const fileInput = document.getElementById('file_input');
		let isDragging = false;

		const audioCtx = new (window.AudioContext || window.webkitAudioContext)();
		const analyser = audioCtx.createAnalyser();
		analyser.fftSize = 2048;

		const source = audioCtx.createMediaElementSource(audio);
		source.connect(analyser);
		analyser.connect(audioCtx.destination);

		// Charger le fichier audio par défaut
		loadDefaultAudio();

		function loadDefaultAudio() {
			fetch('medias/audios/riff.m4a')
				.then(response => response.arrayBuffer())
				.then(data => audioCtx.decodeAudioData(data))
				.then(buffer => {
					drawWaveform(buffer);
					audio.src = 'medias/audios/riff.m4a';
				});
		}

		// Drag and Drop Events
		loadFileButton.addEventListener('dragover', (event) => {
			event.preventDefault();
			loadFileButton.classList.add('dragover');
		});

		loadFileButton.addEventListener('dragleave', () => {
			loadFileButton.classList.remove('dragover');
		});

		loadFileButton.addEventListener('drop', (event) => {
			event.preventDefault();
			loadFileButton.classList.remove('dragover');
			const file = event.dataTransfer.files[0];
			if (file && file.type.startsWith('audio/')) {
				loadAudioFile(file);
			}
		});

		loadFileButton.addEventListener('click', () => {
			fileInput.click();
		});

		fileInput.addEventListener('change', (event) => {
			const file = event.target.files[0];
			if (file) {
				loadAudioFile(file);
			}
		});

		async function loadAudioFile(file) {
			try {
				const arrayBuffer = await file.arrayBuffer();
				const buffer = await audioCtx.decodeAudioData(arrayBuffer);

				const objectURL = URL.createObjectURL(file);
				audio.src = objectURL;

				drawWaveform(buffer);
			} catch (error) {
				console.error('Error loading file:', error);
			}
		}

		function drawWaveform(buffer) {
			const rawData = buffer.getChannelData(0);
			const samples = 600;
			const blockSize = Math.floor(rawData.length / samples);
			const filteredData = [];

			for (let i = 0; i < samples; i++) {
				let blockStart = blockSize * i;
				let sum = 0;
				for (let j = 0; j < blockSize; j++) {
					sum += Math.abs(rawData[blockStart + j]);
				}
				filteredData.push(sum / blockSize);
			}

			const width = waveformCanvas.width;
			const height = waveformCanvas.height;

			waveformCtx.clearRect(0, 0, width, height);
			waveformCtx.fillStyle = 'blue';

			const barWidth = width / samples;
			let x = 0;

			const maxVal = Math.max(...filteredData);

			for (let i = 0; i < samples; i++) {
				const v = (filteredData[i] / maxVal) * height;
				const y = (height - v) / 2;

				waveformCtx.fillRect(x, y, barWidth, v);

				x += barWidth;
			}
		}

		function drawRealtimeWaveform() {
			const width = realtimeCanvas.width;
			const height = realtimeCanvas.height;
			const bufferLength = analyser.frequencyBinCount;
			const dataArray = new Uint8Array(bufferLength);

			realtimeCtx.clearRect(0, 0, width, height);

			analyser.getByteTimeDomainData(dataArray);

			realtimeCtx.fillStyle = 'lightgray';
			realtimeCtx.fillRect(0, 0, width, height);

			realtimeCtx.lineWidth = 2;
			realtimeCtx.strokeStyle = 'blue';
			realtimeCtx.beginPath();

			const sliceWidth = width / bufferLength;
			let x = 0;

			for (let i = 0; i < bufferLength; i++) {
				const v = dataArray[i] / 128.0;
				const y = v * height / 2;

				if (i === 0) {
					realtimeCtx.moveTo(x, y);
				} else {
					realtimeCtx.lineTo(x, y);
				}

				x += sliceWidth;
			}

			realtimeCtx.lineTo(realtimeCanvas.width, realtimeCanvas.height / 2);
			realtimeCtx.stroke();

			requestAnimationFrame(drawRealtimeWaveform);
		}

		drawRealtimeWaveform();

		audio.addEventListener('timeupdate', () => {
			const progressPosition = (audio.currentTime / audio.duration) * waveformCanvas.clientWidth;
			progress.style.left = `${progressPosition}px`;
		});

		audio.addEventListener('play', () => {
			if (audioCtx.state === 'suspended') {
				audioCtx.resume();
			}
		});

		waveformCanvas.addEventListener('mousedown', (event) => {
			audio.pause();
			isDragging = true;
			handleScrub(event);
		});

		document.addEventListener('mouseup', (event) => {
			audio.play();
			if (isDragging) {
				isDragging = false;
				console.log("Mouseup event detected. Dragging stopped.");
			}
		});

		waveformCanvas.addEventListener('mousemove', (event) => {
			if (isDragging) {
				handleScrub(event);
			}
		});

		function handleScrub(event) {
			const rect = waveformCanvas.getBoundingClientRect();
			const scrubX = event.clientX - rect.left;
			console.log(`Mouse X: ${scrubX}, Canvas Width: ${waveformCanvas.clientWidth}`);
			const newTime = (scrubX / waveformCanvas.clientWidth) * audio.duration;
			audio.currentTime = newTime;
		}
JS