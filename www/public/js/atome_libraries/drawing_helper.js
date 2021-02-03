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
        this.frame = new Frame("fit",
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
            $('#view').append($('#atomeZimCanvas'));
            const stage = this.frame.stage;

            function beginDraw(x, y) {
                new Circle(100, pink)
                    .loc(x, y);
                stage.update();
            }

            stage.on("stagemousedown", function() {
                switch (self.mode) {
                    case self.modeType.Use:
                        break;
                    case self.modeType.Draw:
                        beginDraw(stage.mouseX, stage.mouseY);
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