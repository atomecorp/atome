class DrawingHelper {
    constructor(width, height, drawingEventListener) {
        this.width = width;
        this.height = height;

        this.drawingEventListener = drawingEventListener;

        this.modeType = {
            Use: 'Use',
            Select: 'Select',
            Draw: 'Draw'
        };

        this.mode = this.modeType.Use;
    }

    connect() {
        this.frame = new Frame("view",
            this.width,
            this.height,
            light,
            dark,
            undefined,
            undefined,
            undefined,
            undefined,
            undefined,
            undefined,
            undefined,
            undefined,
            "atomeZimCanvas");
        const self = this;
        this.frame.on("ready", () => {
            const stage = this.frame.stage;

            const circle = new zim.Circle(50, green).loc(200, 200);
            stage.update();

            function beginDraw(x, y) {
                circle
                    .top()
                    .animate({x, y}, 0.5);
                stage.update();
            }

            stage.on("stagemousedown", function(e) {
                switch (self.mode) {
                    case self.modeType.Use:
                        break;
                    case self.modeType.Draw:
                        beginDraw(self.frame.mouseX, self.frame.mouseY);
                        break;
                }
            });

            this.drawingEventListener.onConnected();
        });
    }

    setMode(mode) {
        console.log("mode set to " + mode);
        this.mode = mode;
    }
}