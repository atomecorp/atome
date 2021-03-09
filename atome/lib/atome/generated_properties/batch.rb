module Batch
      def delete(value, &proc)
            collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:delete, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def x(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:x, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def xx(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:xx, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def y(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:y, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def yy(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:yy, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def z(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:z, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def center(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:center, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def rotate(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:rotate, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def position(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:position, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def tactile(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:tactile, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def display(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:display, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def color(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:color, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def opacity(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:opacity, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def border(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:border, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def overflow(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:overflow, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def width(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:width, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def height(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:height, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def size(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:size, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def blur(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:blur, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def shadow(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:shadow, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def smooth(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:smooth, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def content(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:content, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def video(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:video, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def box(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:box, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def circle(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:circle, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def text(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:text, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def image(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:image, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def audio(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:audio, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def info(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:info, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def example(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:example, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def parent(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:parent, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def child(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:child, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def insert(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:insert, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def edit(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:edit, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def record(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:record, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def enliven(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:enliven, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def selector(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:selector, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def render(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:render, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def preset(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:preset, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def monitor(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:monitor, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def share(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:share, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def transmit(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:transmit, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def receive(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:receive, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def atome_id(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:atome_id, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def id(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:id, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def type(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:type, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def language(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:language, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def private(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:private, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def can(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:can, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def touch(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:touch, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def drag(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:drag, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

      def over(value, &proc)
        collected_atomes=[]
        read.each do |atome|
          grab(atome).send(:over, value, &proc)
          collected_atomes << atome
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
      end

end
