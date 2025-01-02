#  frozen_string_literal: true

raw_data = <<STR
<iframe width="560" height="315" src="https://www.youtube.com/embed/8BT4Q3UtO6Q?si=WI8RlryV8HW9Y0nz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
STR


raw_data = <<STR
<svg width="600" height="350" xmlns="http://www.w3.org/2000/svg">
<!-- Style for the boxes -->
                         <style>
.box { fill: white; stroke: black; stroke-width: 2; }
   .original { fill: lightblue; }
   .clone { fill: lightgreen; }
   .arrow { stroke: black; stroke-width: 2; marker-end: url(#arrowhead); }
                                                          .text { font-family: Arial, sans-serif; font-size: 14px; }
   </style>

  <!-- Arrowhead definition -->
  <defs>
    <marker id="arrowhead" markerWidth="10" markerHeight="7" 
    refX="0" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="black"/>
     </marker>
  </defs>

   <!-- Boxes for original and clones -->
                                      <rect x="250" y="30" width="100" height="50" class="box original"/>
   <rect x="100" y="200" width="100" height="50" class="box clone"/>
   <rect x="250" y="200" width="100" height="50" class="box clone"/>
   <rect x="400" y="200" width="100" height="50" class="box clone"/>

   <!-- Text for boxes -->
                       <text x="275" y="55" class="text" text-anchor="middle">Original</text>
  <text x="150" y="225" class="text" text-anchor="middle">Clone 1</text>
   <text x="300" y="225" class="text" text-anchor="middle">Clone 2</text>
  <text x="450" y="225" class="text" text-anchor="middle">Clone 3</text>

   <!-- Arrows -->
   <line x1="300" y1="80" x2="150" y2="200" class="arrow"/>
   <line x1="300" y1="80" x2="300" y2="200" class="arrow"/>
   <line x1="300" y1="80" x2="450" y2="200" class="arrow"/>
   </svg>
STR



raw({ id: :the_raw_stuff, data: raw_data })