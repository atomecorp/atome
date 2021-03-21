def run_demo(path)
  clear(:view)
  read(path) do |data|
    compile data
  end
end

def demo_reel(demo_list)
  clear(:view)
  demo_list.each_with_index do |demo, index|
    the_code = text({content: demo[0], y: 20 * index, size: 16})
    the_code.touch do
      run_demo(demo[1])
      next_example = demo_list.keys[index + 1]
      previous_example = demo_list.keys[index - 1]
      back = text({content: :demos, xx: 20})
      back.touch do
        demo_reel(demo_list)
      end

      unless index == 0
        index=index-1
        previous_demo = text(content: :previous, y: 33, xx: 20)
        previous_demo.touch do
          path = demo_list[previous_example]
          run_demo(path)
        end
      end

      unless demo_list.length == index + 1
        index=index+1
        next_demo = text({content: :next, y: 69, xx: 20})
        next_demo.touch do
          path = demo_list[next_example]
          run_demo(path)
        end
      end

    end
  end
end

JSUtils.load_opal_parser
demo_reel=text({content: :demos, xx: 200})
demo_reel.touch do
  read("./medias/rubies/examples/!demos.rb") do |data|
    demos =compile(data)
    demo_reel(demos)
  end
end