module Batch
      def x(value, &proc)
        read.each do |atome|
          grab(atome).send(:x, value, &proc)
        end
      end

      def xx(value, &proc)
        read.each do |atome|
          grab(atome).send(:xx, value, &proc)
        end
      end

      def y(value, &proc)
        read.each do |atome|
          grab(atome).send(:y, value, &proc)
        end
      end

      def yy(value, &proc)
        read.each do |atome|
          grab(atome).send(:yy, value, &proc)
        end
      end

      def z(value, &proc)
        read.each do |atome|
          grab(atome).send(:z, value, &proc)
        end
      end

      def center(value, &proc)
        read.each do |atome|
          grab(atome).send(:center, value, &proc)
        end
      end

      def tactile(value, &proc)
        read.each do |atome|
          grab(atome).send(:tactile, value, &proc)
        end
      end

      def display(value, &proc)
        read.each do |atome|
          grab(atome).send(:display, value, &proc)
        end
      end

      def color(value, &proc)
        read.each do |atome|
          grab(atome).send(:color, value, &proc)
        end
      end

      def opacity(value, &proc)
        read.each do |atome|
          grab(atome).send(:opacity, value, &proc)
        end
      end

      def border(value, &proc)
        read.each do |atome|
          grab(atome).send(:border, value, &proc)
        end
      end

      def overflow(value, &proc)
        read.each do |atome|
          grab(atome).send(:overflow, value, &proc)
        end
      end

      def width(value, &proc)
        read.each do |atome|
          grab(atome).send(:width, value, &proc)
        end
      end

      def height(value, &proc)
        read.each do |atome|
          grab(atome).send(:height, value, &proc)
        end
      end

      def size(value, &proc)
        read.each do |atome|
          grab(atome).send(:size, value, &proc)
        end
      end

      def rotation(value, &proc)
        read.each do |atome|
          grab(atome).send(:rotation, value, &proc)
        end
      end

      def blur(value, &proc)
        read.each do |atome|
          grab(atome).send(:blur, value, &proc)
        end
      end

      def shadow(value, &proc)
        read.each do |atome|
          grab(atome).send(:shadow, value, &proc)
        end
      end

      def smooth(value, &proc)
        read.each do |atome|
          grab(atome).send(:smooth, value, &proc)
        end
      end

      def content(value, &proc)
        read.each do |atome|
          grab(atome).send(:content, value, &proc)
        end
      end

      def video(value, &proc)
        read.each do |atome|
          grab(atome).send(:video, value, &proc)
        end
      end

      def box(value, &proc)
        read.each do |atome|
          grab(atome).send(:box, value, &proc)
        end
      end

      def circle(value, &proc)
        read.each do |atome|
          grab(atome).send(:circle, value, &proc)
        end
      end

      def text(value, &proc)
        read.each do |atome|
          grab(atome).send(:text, value, &proc)
        end
      end

      def image(value, &proc)
        read.each do |atome|
          grab(atome).send(:image, value, &proc)
        end
      end

      def audio(value, &proc)
        read.each do |atome|
          grab(atome).send(:audio, value, &proc)
        end
      end

      def info(value, &proc)
        read.each do |atome|
          grab(atome).send(:info, value, &proc)
        end
      end

      def example(value, &proc)
        read.each do |atome|
          grab(atome).send(:example, value, &proc)
        end
      end

      def parent(value, &proc)
        read.each do |atome|
          grab(atome).send(:parent, value, &proc)
        end
      end

      def child(value, &proc)
        read.each do |atome|
          grab(atome).send(:child, value, &proc)
        end
      end

      def insert(value, &proc)
        read.each do |atome|
          grab(atome).send(:insert, value, &proc)
        end
      end

      def edit(value, &proc)
        read.each do |atome|
          grab(atome).send(:edit, value, &proc)
        end
      end

      def record(value, &proc)
        read.each do |atome|
          grab(atome).send(:record, value, &proc)
        end
      end

      def enliven(value, &proc)
        read.each do |atome|
          grab(atome).send(:enliven, value, &proc)
        end
      end

      def selector(value, &proc)
        read.each do |atome|
          grab(atome).send(:selector, value, &proc)
        end
      end

      def render(value, &proc)
        read.each do |atome|
          grab(atome).send(:render, value, &proc)
        end
      end

      def preset(value, &proc)
        read.each do |atome|
          grab(atome).send(:preset, value, &proc)
        end
      end

      def monitor(value, &proc)
        read.each do |atome|
          grab(atome).send(:monitor, value, &proc)
        end
      end

      def share(value, &proc)
        read.each do |atome|
          grab(atome).send(:share, value, &proc)
        end
      end

      def atome_id(value, &proc)
        read.each do |atome|
          grab(atome).send(:atome_id, value, &proc)
        end
      end

      def id(value, &proc)
        read.each do |atome|
          grab(atome).send(:id, value, &proc)
        end
      end

      def type(value, &proc)
        read.each do |atome|
          grab(atome).send(:type, value, &proc)
        end
      end

      def language(value, &proc)
        read.each do |atome|
          grab(atome).send(:language, value, &proc)
        end
      end

      def private(value, &proc)
        read.each do |atome|
          grab(atome).send(:private, value, &proc)
        end
      end

      def can(value, &proc)
        read.each do |atome|
          grab(atome).send(:can, value, &proc)
        end
      end

      def touch(value, &proc)
        read.each do |atome|
          grab(atome).send(:touch, value, &proc)
        end
      end

      def drag(value, &proc)
        read.each do |atome|
          grab(atome).send(:drag, value, &proc)
        end
      end

      def over(value, &proc)
        read.each do |atome|
          grab(atome).send(:over, value, &proc)
        end
      end

end
