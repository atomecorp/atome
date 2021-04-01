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

        this.frame = new Frame("view",
            this.width,
            this.height,
            "rgba(125,125,125,1)",
            light,
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

            var backing = new Rectangle(this.frame.width, this.frame.height, "rgba(125,125,125,1)").center();

            const precision = 25;
            const curving = 0.15;
            const color = red;
            const thickness = 4;

            let points = [];
            let squiggle;
            let squiggleInitialised = false;

            function beginDraw(x, y) {
                points.push([x,y]);

                squiggle = new Squiggle({
                    color: color,
                    thickness: thickness,
                    controlType: "none",
                    interactive: false
                });

                stage.update();
            }

            function mouseDrag(x, y) {
                const lastX = points[points.length - 1][0];
                const lastY = points[points.length - 1][1];

                if (dist(lastX, lastY, x, y) > precision) {
                    points.push([x, y]);
                    squiggle.points = points;

                    if(!squiggleInitialised) {
                        squiggle.addTo();
                        squiggleInitialised = true;
                    }
                    stage.update();
                }
            }

            function mouseUp(x, y) {
                points.push([x, y]);

                zim.loop(squiggle.pointObjects, function(obj, i, t){
                    if (i===0) return;
                    if (i===t-1) return;
                    const previousPoint = squiggle.pointControls[i - 1];
                    const nextPoint = squiggle.pointControls[i + 1];

                    obj[2].x= -(nextPoint.x - previousPoint.x) * curving;
                    obj[2].y= -(nextPoint.y - previousPoint.y) * curving;

                    obj[3].x= (nextPoint.x - previousPoint.x) * curving;
                    obj[3].y= (nextPoint.y - previousPoint.y) * curving;

                    obj[4] = "free";
                });
                squiggle.update();

                points = [];
                squiggleInitialised = false;

                stage.update();
            }

            backing.on("mousedown", function() {
                switch (self.mode) {
                    case self.modeType.Use:
                        break;
                    case self.modeType.Draw:
                        beginDraw(self.frame.mouseX, self.frame.mouseY);
                        break;
                }
            });

            backing.on("pressmove", function() {
                switch (self.mode) {
                    case self.modeType.Use:
                        break;
                    case self.modeType.Draw:
                        mouseDrag(self.frame.mouseX, self.frame.mouseY);
                        break;
                }
            });

            backing.on("pressup", function () {
                switch (self.mode) {
                    case self.modeType.Use:
                        break;
                    case self.modeType.Draw:
                        mouseUp(self.frame.mouseX, self.frame.mouseY);
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