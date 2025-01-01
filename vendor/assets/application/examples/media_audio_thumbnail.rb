# frozen_string_literal: true



audio({id: :audio})
waveform_container=box({id: 'waveform-container', width: 666, height: 270, color: :gray})
waveform_container.draw({width: 666, height: 270,  id: :waveform})
waveform_container.box({id: 'progress', width: 3, height: '100%', color: :red})

draw({width: 666, height: 270, top: 280,color: :orange, id: :realtime})


box({id: :load_file, top: 666, left: 12, width: 300, height: 40, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 } })
box({id: :file_input, top: 777, left: 12, width: 300, height: 40, smooth: 9, color: { red: 0.3, green: 0.3, blue: 0.3 } })



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
			const samples = waveformCanvas.width;
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
			waveformCtx.fillStyle = 'black';

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

			realtimeCtx.lineWidth = 1;
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
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "0",
    "3",
    "AudioContext",
    "abs",
    "addEventListener",
    "arrayBuffer",
    "beginPath",
    "box",
    "classList",
    "clearRect",
    "click",
    "clientWidth",
    "clientX",
    "connect",
    "createAnalyser",
    "createMediaElementSource",
    "createObjectURL",
    "currentTime",
    "dataTransfer",
    "decodeAudioData",
    "destination",
    "draw",
    "duration",
    "error",
    "eval",
    "fftSize",
    "fillRect",
    "fillStyle",
    "floor",
    "frequencyBinCount",
    "getBoundingClientRect",
    "getByteTimeDomainData",
    "getChannelData",
    "getContext",
    "getElementById",
    "height",
    "left",
    "length",
    "lineTo",
    "lineWidth",
    "log",
    "m4a",
    "max",
    "moveTo",
    "pause",
    "play",
    "preventDefault",
    "push",
    "resume",
    "src",
    "state",
    "stroke",
    "strokeStyle",
    "style",
    "target",
    "type",
    "webkitAudioContext",
    "width"
  ],
  "0": {
    "aim": "The `0` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `0`."
  },
  "3": {
    "aim": "The `3` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `3`."
  },
  "AudioContext": {
    "aim": "The `AudioContext` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `AudioContext`."
  },
  "abs": {
    "aim": "The `abs` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `abs`."
  },
  "addEventListener": {
    "aim": "The `addEventListener` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `addEventListener`."
  },
  "arrayBuffer": {
    "aim": "The `arrayBuffer` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `arrayBuffer`."
  },
  "beginPath": {
    "aim": "The `beginPath` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `beginPath`."
  },
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "classList": {
    "aim": "The `classList` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `classList`."
  },
  "clearRect": {
    "aim": "The `clearRect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `clearRect`."
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
  "connect": {
    "aim": "The `connect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `connect`."
  },
  "createAnalyser": {
    "aim": "The `createAnalyser` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `createAnalyser`."
  },
  "createMediaElementSource": {
    "aim": "The `createMediaElementSource` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `createMediaElementSource`."
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
  "decodeAudioData": {
    "aim": "The `decodeAudioData` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `decodeAudioData`."
  },
  "destination": {
    "aim": "The `destination` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `destination`."
  },
  "draw": {
    "aim": "The `draw` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `draw`."
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
  "fftSize": {
    "aim": "The `fftSize` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fftSize`."
  },
  "fillRect": {
    "aim": "The `fillRect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fillRect`."
  },
  "fillStyle": {
    "aim": "The `fillStyle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fillStyle`."
  },
  "floor": {
    "aim": "The `floor` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `floor`."
  },
  "frequencyBinCount": {
    "aim": "The `frequencyBinCount` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `frequencyBinCount`."
  },
  "getBoundingClientRect": {
    "aim": "The `getBoundingClientRect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getBoundingClientRect`."
  },
  "getByteTimeDomainData": {
    "aim": "The `getByteTimeDomainData` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getByteTimeDomainData`."
  },
  "getChannelData": {
    "aim": "The `getChannelData` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getChannelData`."
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
  "length": {
    "aim": "The `length` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `length`."
  },
  "lineTo": {
    "aim": "The `lineTo` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `lineTo`."
  },
  "lineWidth": {
    "aim": "The `lineWidth` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `lineWidth`."
  },
  "log": {
    "aim": "The `log` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `log`."
  },
  "m4a": {
    "aim": "The `m4a` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `m4a`."
  },
  "max": {
    "aim": "The `max` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `max`."
  },
  "moveTo": {
    "aim": "The `moveTo` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `moveTo`."
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
  "push": {
    "aim": "The `push` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `push`."
  },
  "resume": {
    "aim": "The `resume` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `resume`."
  },
  "src": {
    "aim": "The `src` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `src`."
  },
  "state": {
    "aim": "The `state` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `state`."
  },
  "stroke": {
    "aim": "The `stroke` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `stroke`."
  },
  "strokeStyle": {
    "aim": "The `strokeStyle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `strokeStyle`."
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
  "webkitAudioContext": {
    "aim": "The `webkitAudioContext` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `webkitAudioContext`."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end
